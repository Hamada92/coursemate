class User < ActiveRecord::Base

  def to_param
    "#{id}-#{username.parameterize}"
  end

  MAX_AVATAR_UPLOAD_SIZE_MB = 10.freeze
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/#{ENV['S3_BUCKET_CACHE_NAME']}\.s3\.amazonaws\.com\/.*\.(jpg|jpeg|JPG|JPEG)(\?transform=[0-9a-z\-]+)?\z}.freeze

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :created_groups, class_name: 'Group', foreign_key: 'creator_id', dependent: :destroy
  has_many :group_enrollments, dependent: :destroy
  has_many :groups, through: :group_enrollments

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/,
    message: "only allows letters (a-z) and numbers" }
  validate :valid_email
  validates :avatar_temp, allow_blank: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }
  
  before_create :set_university
  after_commit :enqueue_image, on: :update

  # override the send_devise_notification to use ActiveJob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def is_ambassador?
    privileges >= 1
  end

  def is_admin?
    privileges >= 2
  end

  def is_master?
    privileges >= 3
  end

  def unread_notifications_count
    notifications.where(read: false).count
  end

  def questions_he_answered
    Question.joins(:answers).where(answers: { user_id: self.id} ).distinct
  end

  #is this user enrolled in the passed group?
  def in_group?(group_id)
    groups.any? do |group|
      group.id == group_id
    end
  end

  private

    def valid_email
      domain = self.email.partition('@').last
      unless UsersHelper::UNIVERSITIES.any? {|u| u[:domain] == domain}
        errors.add(:email, "is not a valid university email")
      end
    end

    def set_university
      domain = self.email.partition('@').last
      self.university = UsersHelper::UNIVERSITIES.select{|u| u[:domain] == domain}.map{|u| u[:name]}.first
    end

    def enqueue_image
      if avatar_temp.present?
        update_column(:processing_avatar, true)
        AvatarWorker.perform_async(id)
      end
    end

end

class User < ActiveRecord::Base

  def to_param
    "#{id}-#{username.parameterize}"
  end

  MAX_AVATAR_UPLOAD_SIZE_MB = 10.freeze
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/#{ENV['S3_BUCKET_CACHE_NAME']}\.s3\.amazonaws\.com\/.*\.(jpg|jpeg|JPG|JPEG)(\?transform=[0-9a-z\-]+)?\z}.freeze

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :questions
  has_many :question_indices, foreign_key: [:user_id]
  has_many :answers
  has_many :comment_statuses, dependent: :destroy

  has_many :comments
  has_many :likes
  has_many :group_enrollments
  has_many :group_indices, through: :group_enrollments
  has_many :notification_lists, foreign_key: 'notified_user'
  has_many :courses, class_name: 'UserCourse'
  belongs_to :university, foreign_key: 'university_domain'

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/,
    message: "only allows letters (a-z) and numbers" }
  validate :valid_university_email, if: Proc.new{|object| object.errors.empty?}
  validates :avatar_temp, allow_blank: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }
  
  before_create :set_university
  after_commit :enqueue_image, on: :update

  # override the send_devise_notification to use ActiveJob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.with_score
    User.joins("left join (select questions.user_id, count(*) * 5 as question_likes_score from likes 
      join questions on likes.question_id = questions.id 
      group by questions.user_id) t1
    on t1.user_id = users.id 
    left join 
     (select answers.user_id, count(*) * 10 as answer_likes_score from likes 
      join answers on likes.answer_id = answers.id 
        group by answers.user_id) t2
    on t2.user_id = users.id").select("users.*, COALESCE(COALESCE(t1.question_likes_score, 0) + COALESCE(t2.answer_likes_score, 0), 0) as score")
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
    0
  end

  def questions_he_answered
    QuestionIndex.joins(:answers).where(answers: { user_id: self.id} ).distinct
  end  

  def unread_notification_count
    notification_lists.where(seen: false).count
  end


  private

    def find_university_with_domain
      #user sign up
      @university ||= University.where(" ? LIKE CONCAT('%@', domain) ", self.email).first
    end

    def valid_university_email
      unless find_university_with_domain
        errors.add(:email, "is not a valid university email")
      end
    end

    def set_university
      self.university = find_university_with_domain
    end

    def enqueue_image
      if avatar_temp.present?
        update_column(:processing_avatar, true)
        AvatarWorker.perform_async(id)
      end
    end

end

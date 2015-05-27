class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validate :valid_email
  before_create :set_university

  def questions_he_answered
    Question.joins(:answers).where(answers: { user_id: self.id} ).distinct
  end

  private

    def valid_email
      domain = self.email.partition('@').last
      unless UsersHelper::UNIVERSITIES.any? {|u| u[:domain] == domain}
        errors.add(:base, "Please use a valid university email")
      end
    end


    def set_university
      domain = self.email.partition('@').last
      self.university = UsersHelper::UNIVERSITIES.select{|u| u[:domain] == domain}.map{|u| u[:name]}.first
    end

end
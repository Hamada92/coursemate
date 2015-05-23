class Question < ActiveRecord::Base
  

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  validates_inclusion_of :course_name, in: QuestionsHelper::COURSES

  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy


  before_create :set_university

  def set_university
    self.university = self.user.university
  end

  def self.unanswered
    includes(:answers).where(answers: { id: nil })
  end

  def self.from_subject name
    where(course_name: name)
  end

  def self.from_course name, number
    where(course_name: name, course_number: number)
  end

  def likes_by user
    self.likes.where(user_id: user.id)
  end

  def self.from_university user
    where(university: user.university)
  end

end

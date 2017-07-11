class Answer < ActiveRecord::Base
  
  belongs_to :question
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  validates :body, presence: true

  after_create :notify_question_owner, unless: :answer_owner_is_question_owner?

  def notify_question_owner
    Notification.create(answer_id: self.id, user_id: self.question.user_id)
  end

  def answer_owner_is_question_owner?
    user == question.user
  end

end

class Comment < ActiveRecord::Base

  has_many :notifications, as: :notifier, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  after_create :create_notification, unless: :commenter_is_commentable_owner?

  def commenter_is_commentable_owner?
    user_id == commentable.user_id
  end

  def create_notification
    question_id = commentable_type == 'Question' ? commentable_id : commentable.question_id
    notifications.create(user_id: commentable.user_id, question_id: question_id)
  end
  
end

class Comment < ActiveRecord::Base

  #stores if the comment was seen by the user or not
  has_many   :comment_statuses
  has_many   :notifications
  belongs_to :question
  belongs_to :answer
  belongs_to :group
  belongs_to :user

  validates :body, presence: true

  def commentable
    @commentable ||= (self.question if self.question_id.present?) || (self.answer if self.answer_id.present?) || self.group
  end

  def commentable_id
    @commentable_id ||= (self.question_id if self.question_id.present?) || (self.answer_id if self.answer_id.present?) || self.group_id
  end

  def commentable_type
    @commentable_type ||= ('Question' if self.question_id.present?) || ('Answer' if self.answer_id.present?) || 'Group'
  end
  
end

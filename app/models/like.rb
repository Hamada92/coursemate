class Like < ActiveRecord::Base

  has_many   :notifications
  belongs_to :answer
  belongs_to :question
  belongs_to :user

  validate :user_doesnt_own_post

  def likeable
    @likeable ||= self.question_id.present? ? self.question : self.answer
  end

  def likeable_id
    @likeable_id ||= self.question_id.present? ? self.question_id : self.answer_id
  end

  def likeable_type
    @likeable_type ||= self.question_id.present? ? 'Question' : 'Answer'
  end

  private

    def user_doesnt_own_post
      if user_id == likeable.user_id
        errors.add(:base, "Can't vote on your own post")
      end
    end
end

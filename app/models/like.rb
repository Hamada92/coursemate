class Like < ActiveRecord::Base

  belongs_to :answer
  belongs_to :question
  belongs_to :user

  def likeable
    @likeable ||= self.question_id.present? ? self.question : self.answer
  end

  def likeable_id
    @likeable_id ||= self.question_id.present? ? self.question_id : self.answer_id
  end

  def likeable_type
    @likeable_type ||= self.question_id.present? ? 'Question' : 'Answer'
  end
end

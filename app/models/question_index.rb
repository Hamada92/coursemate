class QuestionIndex < ApplicationRecord
  self.primary_key = 'id'

  default_scope { order(id: :desc) }

  belongs_to :user
  has_many :answers, foreign_key: [:question_id]

  scope :unanswered, ->  { where(num_answers: 0) }
end

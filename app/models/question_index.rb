class QuestionIndex < ApplicationRecord
  self.primary_key = 'id'
  
  belongs_to :user
  has_many :answers, foreign_key: [:question_id]
end

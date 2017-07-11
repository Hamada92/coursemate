class QuestionShow < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :user
  has_many :comments, foreign_key: [:question_id]
  has_many :answer_shows, foreign_key: [:question_id]
  
end

class AnswerShow < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :question
  belongs_to :user
  has_many :comments, foreign_key: [:answer_id] #specify foreign key, otherwise it will use answer_show.id
  has_many :likes, foreign_key: [:answer_id]


end

class GroupShow < ApplicationRecord
  self.primary_key = 'id'

  has_many :comments, foreign_key: [:group_id]
  belongs_to :user_with_score, foreign_key: [:creator_id]
end

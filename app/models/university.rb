class University < ApplicationRecord
  self.primary_key = 'domain'
  
  has_many :courses, foreign_key: 'university_domain', dependent: :destroy
  has_many :users, foreign_key: 'university_domain', dependent: :destroy
  has_many :groups, foreign_key: 'university_domain', dependent: :destroy
  has_many :questions, foreign_key: 'university_domain', dependent: :destroy
  has_many :group_indices, foreign_key: 'university_domain'
  has_many :question_indices, foreign_key: 'university_domain'
end

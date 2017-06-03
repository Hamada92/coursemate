class University < ApplicationRecord
  self.primary_key = 'domain'
  has_many :courses, foreign_key: 'university_domain', dependent: :destroy
  has_many :users, foreign_key: 'university_domain', dependent: :destroy
end

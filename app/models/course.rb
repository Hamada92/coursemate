class Course < ApplicationRecord
  self.primary_keys = [:name, :university_domain]
  belongs_to :university, foreign_key: 'university_domain', required: true
  has_many :groups, foreign_key: [:course_name, :university_domain]

  validates :name, presence: true
end

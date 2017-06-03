class Course < ApplicationRecord
  self.primary_keys = [:name, :university_domain]
  belongs_to :university, foreign_key: 'university_domain', required: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :university_domain }

end

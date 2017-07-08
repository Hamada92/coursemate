class Course < ApplicationRecord

  default_scope { order(name: :asc) }

  self.primary_keys = [:name, :university_domain]

  belongs_to :university, foreign_key: 'university_domain', required: true
  has_many :groups, foreign_key: [:course_name, :university_domain]
  has_many :questions, foreign_key: [:course_name, :university_domain]
  has_many :group_indices, foreign_key: [:course_name, :university_domain]
  has_many :question_indices, foreign_key: [:course_name, :university_domain]



  validates :name, presence: true

  before_create :capitalize_and_strip_spaces

  private

    def capitalize_and_strip_spaces
      self.name = name.upcase.strip.gsub(/ +/,"")
    end
end

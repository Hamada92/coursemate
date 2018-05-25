class QuestionIndex < ApplicationRecord
  self.primary_key = 'id'

  default_scope { order(id: :desc) }

  belongs_to :user
  has_many :answers, foreign_key: [:question_id]

  scope :unanswered, -> (course_name, university_domain) { 
    where(course_name: @course.name, university_domain: @course.university_domain, num_answers: 0 }
end

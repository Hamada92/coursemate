class UserCourse < ActiveRecord::Base
  self.primary_keys = [:user_id, :course_name, :university_domain]
  
  belongs_to :user
  belongs_to :course, foreign_key: [:course_name, :university_domain]

  validates_uniqueness_of :user_id, scope: [:course_name, :university_domain], message: 'You have already added this course'
end

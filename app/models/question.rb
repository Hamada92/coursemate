class Question < ActiveRecord::Base

  default_scope { order(id: :desc) }

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :university, foreign_key: 'university_domain', required: true
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true
  has_one :question_html_body, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

end

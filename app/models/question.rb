class Question < ActiveRecord::Base

  default_scope { order(id: :desc) }

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :university, foreign_key: 'university_domain', required: true
  belongs_to :course, foreign_key: [:course_name, :university_domain], required: true

  validates :title, presence: true
  validates :body, presence: true

  def like_by user_id
    likes.find{ |like| like.user_id == user_id }
  end
end

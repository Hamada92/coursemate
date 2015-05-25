class Question < ActiveRecord::Base
  

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true

  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  accepts_nested_attributes_for :tags


  def self.unanswered
    includes(:answers).where(answers: { id: nil })
  end

  def self.from_subject name
    where(course_name: name)
  end

  def self.from_course name, number
    where(course_name: name, course_number: number)
  end

  def likes_by user
    self.likes.where(user_id: user.id)
  end

  def self.from_university user
    where(university: user.university)
  end

  def tags_attributes=(hash)
    hash.each do |sequence, tag_values|
      tags <<  Tag.where(name: tag_values[:name], category: tag_values[:category]).first_or_create
    end
  end

end

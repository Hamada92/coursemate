class Question < ActiveRecord::Base
  

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  validate :university_hidden_field

  before_destroy :cleanup


  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings, dependent: :destroy
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
      self.tags <<  Tag.where(category: tag_values[:category], name: tag_values[:name], university: tag_values[:university]).first_or_create
    end
  end

  private

    def university_hidden_field
      unless self.tags.first[:university] == self.user.university
        errors.add(:base, "You can't modify the university hidden field")
      end
    end

    def cleanup 
      question_tag_id = self.tags.first.id
      if Tagging.where(tag_id: self.tags.first.id).count == 1 # means we have only one tagging and therefore one question with this tag, so if we destroy this last question we should also destroy the tag
        Tag.find(question_tag_id ).destroy
      end
    end


end

class Question < ActiveRecord::Base
  

  validates :title, presence: true
  validate :user_from_university

  after_destroy :cleanup_orphan_tags
  after_update :cleanup_orphan_tags
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

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
      self.tags = [Tag.where(category: tag_values[:category], name: tag_values[:name], university: tag_values[:university]).first_or_create]
    end
  end

  private

    def user_from_university
      unless self.tags.first[:university] == self.user.university
        errors.add(:base, "You may only post questions for your university")
      end
    end

    def cleanup_orphan_tags
      # rails issue 778
      # add -1 to array to prevent array from being empty and running into this issue
      Tag.where("id not in (?)", [-1] + Tagging.pluck(:tag_id)).destroy_all
    end

end

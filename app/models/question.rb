class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  accepts_nested_attributes_for :tags

  validates :title, presence: true
  validates :body, presence: true
  validate :user_from_university
  validate :valid_tag
  validate :valid_category

  after_destroy :cleanup_orphan_tags
  after_update :cleanup_orphan_tags
  
  def self.unanswered_with_tag id
    includes(:answers, :taggings).where(answers: { id: nil }).where(taggings: { tag_id: id})
  end

  def self.tagged_with id
    joins(:taggings).where(taggings: { tag_id: id })
  end

  def self.tagged_with_university university
    joins(:taggings, :tags).where(tags: { university: university })
  end

  def likes_by user
    self.likes.where(user_id: user.id)
  end

  def tags_attributes=(hash)
    hash.each do |sequence, tag_values|
      self.tags = [Tag.where(category: tag_values[:category], name: tag_values[:name], university: tag_values[:university]).first_or_create]
    end
  end

  private

    def valid_category
      unless QuestionsHelper::CATEGORIES.include?(self.tags.first.category)
        errors.add(:base, "Please use a valid question category")
      end
    end

    def valid_tag
      tag = self.tags.first
      if tag.category == "University Related"
        unless tag.name == "General"
          errors.add(:base, "University related questions must be tagged with \'General\'")
        end
      elsif tag.category == "Course Related"
        unless tag.name =~ /\A *[A-Za-z0-9]+ +[A-Za-z0-9]+ *\Z/
          errors.add(:base, "A course must be composed of a course code and a course number seperated by a space")
        end
      else
        if tag.name.blank?
          errors.add(:base, "Please enter a valid program")
        end
      end
    end

    def user_from_university
      unless self.tags.first[:university] == self.user.university
        errors.add(:base, "You may only post questions for your university")
      end
    end

    def cleanup_orphan_tags
      Tag.includes(:taggings).where(taggings: { id: nil }).destroy_all
    end

end

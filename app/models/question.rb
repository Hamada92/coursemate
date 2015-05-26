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

  def self.tagged_with id
    joins(:taggings).where(taggings: { tag_id: id })
  end

  def self.tagged_with_university university
    joins(:taggings, :tags).where(tags: { university: university })
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
      Tag.includes(:taggings).where(taggings: { id: nil }).destroy_all
    end

end

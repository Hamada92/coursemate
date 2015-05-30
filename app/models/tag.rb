class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates_inclusion_of :category, in: QuestionsHelper::CATEGORIES
  validates :name, presence: true

  def self.with_university university
    Tag.where(university: university)
  end



end

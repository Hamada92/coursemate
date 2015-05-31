class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates_inclusion_of :category, in: QuestionsHelper::CATEGORIES

  before_create :clean_tag

  def self.with_university university
    Tag.where(university: university)
  end

  def self.all_universities
    Tag.pluck(:university).uniq
  end

  def clean_tag
    if self.category == "Course Related"
      self.name = self.name.strip
      self.name.gsub(/ +/," ")
      self.name = self.name.upcase
    elsif self.category == "Program Related"
      self.name = self.name.split.map(&:capitalize).join(' ')
    end
  end

end

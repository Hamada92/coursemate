class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates_inclusion_of :category, in: QuestionsHelper::CATEGORIES
  validates :name, presence: true
  validate :valid_tag

  before_create :clean_tag

  def self.with_university university
    Tag.where(university: university)
  end

  def self.all_universities
    Tag.pluck(:university).uniq
  end

  def valid_tag
    if self.category == "University Related"
      unless self.name == "General"
        errors.add(:base, "University related questions must be tagged with \'General\'")
      end
    elsif self.category == "Course Related"
      unless self.name =~ /\A *[A-Za-z0-9]+ +[A-Za-z0-9]+ *\Z/
        errors.add(:base, "A course must be composed of a course code and a course number seperated by a space")
      end
    end
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

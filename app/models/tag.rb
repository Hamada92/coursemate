class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  before_create :clean_tag

  def self.with_university university
    Tag.where(university: university)
  end

  def self.all_universities
    Tag.pluck(:university).uniq
  end

end

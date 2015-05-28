class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  def self.with_university university
    Tag.where(university: university)
  end

end

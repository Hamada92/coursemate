class GroupTag < ApplicationRecord
  has_many :group_taggings, dependent: :destroy
  has_many :groups, through: :group_taggings

  def self.names_with university
    where(university: university).pluck(:name)
  end

  def self.all_universities
    GroupTag.pluck(:university).uniq
  end

  def self.with_university university
    GroupTag.where(university: university)
  end

end

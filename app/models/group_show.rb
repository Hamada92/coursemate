class GroupShow < ApplicationRecord
  self.primary_key = 'id'

  has_many :comments
end

class GroupIndex < ApplicationRecord
  include GroupMethods
  self.primary_key = 'id'

  default_scope { order("CASE status WHEN 'active' THEN 1 ELSE 2 END") }      

  belongs_to :creator, class_name: 'User'

end

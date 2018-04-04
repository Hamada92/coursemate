class GroupIndex < ApplicationRecord
  include GroupMethods
  self.primary_key = 'id'
  self.table_name = "group_indices_unmaterialized"

  # active groups first ordered by id, then completed and cancelled ordererd by id
  default_scope { order("CASE status WHEN 'active' THEN 1 ELSE 2 END ASC, id DESC") }      

  belongs_to :creator, class_name: 'User'

end

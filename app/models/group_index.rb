class GroupIndex < ApplicationRecord
  include GroupMethods
  self.primary_key = 'id'

  default_scope { order(status: :asc, id: :desc) }      

  belongs_to :creator, class_name: 'User'

end

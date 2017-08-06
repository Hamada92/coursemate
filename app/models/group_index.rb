class GroupIndex < ApplicationRecord
  self.primary_key = 'id'

  default_scope { order(id: :desc) }

  belongs_to :creator, class_name: 'User'

  def cancelled?
    status == 'cancelled'
  end

end

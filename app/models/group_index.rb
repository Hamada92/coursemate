class GroupIndex < ApplicationRecord
  self.primary_key = 'id'
  belongs_to :creator, class_name: 'User'

  def cancelled?
    status == 'cancelled'
  end

end

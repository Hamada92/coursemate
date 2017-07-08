class GroupIndex < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  def cancelled?
    status == 'cancelled'
  end

end

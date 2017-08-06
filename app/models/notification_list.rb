class NotificationList < ApplicationRecord

  default_scope { order "id DESC"}

  self.primary_key = 'id'
  belongs_to :user, foreign_key: 'notified_user'

end

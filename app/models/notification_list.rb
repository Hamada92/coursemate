class NotificationList < ApplicationRecord
  self.primary_key = 'id'
  belongs_to :user, foreign_key: 'notified_user'
end

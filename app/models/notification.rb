class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :source, polymorphic: true #source is the resource that we redirect to when the user 
  #clicks the notification, (i.e. question or group), not to be mistaken with the notifier itself (comment, answer, like)
  belongs_to :notifier, polymorphic: true
  
end

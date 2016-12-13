class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :notifier, polymorphic: true
  
end

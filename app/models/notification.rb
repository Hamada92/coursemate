class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  belongs_to :comment
  belongs_to :like
end

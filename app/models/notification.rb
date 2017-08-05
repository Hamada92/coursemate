class Notification < ApplicationRecord

  default_scope { order(id: :desc) }

  belongs_to :answer
  belongs_to :comment
  belongs_to :like
end

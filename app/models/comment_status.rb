class CommentStatus < ApplicationRecord
  self.primary_keys = [:comment_id, :user_id]

  belongs_to :user
  belongs_to :comment
end

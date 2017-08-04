class CommentStatus < ApplicationRecord
  self.primary_keys = [:comment_id, :user_id]
end

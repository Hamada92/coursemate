class DropCommentStatuses < ActiveRecord::Migration[5.0]
  def change
    drop_table :comment_statuses
  end
end

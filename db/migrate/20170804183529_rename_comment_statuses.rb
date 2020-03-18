class RenameCommentStatuses < ActiveRecord::Migration[5.0][5.0]
  def change
    rename_table :group_comment_statuses, :comment_statuses
  end
end

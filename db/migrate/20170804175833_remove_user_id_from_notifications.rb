class RemoveUserIdFromNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :user_id, :int
    remove_column :notifications, :read, :boolean
  end
end

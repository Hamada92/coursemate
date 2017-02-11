class AddNotificationSourceTypeAndIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :source_type, :string
    add_column :notifications, :source_id, :integer
    add_index :notifications, :source_type
    add_index :notifications, :source_id
  end
end

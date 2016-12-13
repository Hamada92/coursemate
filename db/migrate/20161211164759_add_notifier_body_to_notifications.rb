class AddNotifierBodyToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :notifier_body, :string
  end
end

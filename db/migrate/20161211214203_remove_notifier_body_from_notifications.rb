class RemoveNotifierBodyFromNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :notifier_body
    remove_column :notifications, :question_title
  end
end

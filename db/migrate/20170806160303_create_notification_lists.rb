class CreateNotificationLists < ActiveRecord::Migration[5.0][5.0]
  def change
    create_view :notification_lists
  end
end

class UpdateNotificationListsToVersion3 < ActiveRecord::Migration[5.0]
  def change
    update_view :notification_lists, version: 3, revert_to_version: 2
  end
end

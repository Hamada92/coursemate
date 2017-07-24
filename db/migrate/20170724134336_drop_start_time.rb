class DropStartTime < ActiveRecord::Migration[5.0]
  def change
    drop_view :group_shows
    drop_view :group_indices
    remove_column :groups, :start_time, :time
    create_view :group_shows
    create_view :group_indices
    update_view :group_shows, version: 3
    update_view :group_indices, version: 3
  end
end

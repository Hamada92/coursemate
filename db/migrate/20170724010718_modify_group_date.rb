class ModifyGroupDate < ActiveRecord::Migration[5.0]
  def up
    drop_view :group_shows
    drop_view :group_indices
    execute <<-SQL
      alter table groups drop constraint IF EXISTS day_at_leat_today;
      alter table groups alter column day TYPE timestamp with time zone;
    SQL
    create_view :group_shows
    create_view :group_indices
    update_view :group_shows, version: 3
    update_view :group_indices, version: 3
  end
end

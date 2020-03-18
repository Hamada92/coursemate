class ModifyGroupsConstraints < ActiveRecord::Migration[5.0][5.0]
  def up
    drop_view :group_shows
    drop_view :group_indices

    execute <<-SQL
      alter table groups drop constraint IF EXISTS day_at_least_today;
      alter table groups drop constraint IF EXISTS day_at_leat_today;
      alter table groups drop constraint IF EXISTS end_time_greater_than_start_time;
      alter table groups ADD CHECK(starts_at AT TIME ZONE 'UTC' >= current_timestamp) NOT VALID
    SQL

    create_view :group_shows
    create_view :group_indices
    update_view :group_shows, version: 3
    update_view :group_indices, version: 3
  end
end

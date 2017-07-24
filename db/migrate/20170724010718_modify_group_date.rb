class ModifyGroupDate < ActiveRecord::Migration[5.0]
  def up
    drop_view :group_shows
    drop_view :group_indices
    execute <<-SQL
      alter table groups alter column day TYPE timestamp with time zone;
      alter table groups add constraint day_at_least_today CHECK(date(day AT TIME ZONE 'UTC') >= current_date);
    SQL
    create_view :group_shows
    create_view :group_indices
    update_view :group_shows, version: 3
    update_view :group_indices, version: 3
  end
end

class ConvertTimeToTimestamp < ActiveRecord::Migration[5.0][5.0]
  def up
    drop_view :group_shows
    drop_view :group_indices

    execute <<-SQL
      alter table groups alter column ends_at TYPE timestamp with time zone USING starts_at + interval '1 hour';
    SQL

    create_view :group_shows
    create_view :group_indices
    update_view :group_shows, version: 3
    update_view :group_indices, version: 3
  end
end

class IndexEndsAtStatus < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create index ends_at_status_groups on groups(ends_at, status);
    SQL
  end
end

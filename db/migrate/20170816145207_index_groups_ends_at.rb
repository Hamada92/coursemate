class IndexGroupsEndsAt < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create index group_ends_at on groups(ends_at)
    SQL
  end
end

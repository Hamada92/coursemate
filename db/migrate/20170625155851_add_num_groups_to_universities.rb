class AddNumGroupsToUniversities < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table universities ADD num_groups integer default 0;
      create index num_groups_universities on universities(num_groups);
    SQL
  end

  def down
    execute <<-SQL
      alter table universities DROP num_groups;
    SQL
  end
end

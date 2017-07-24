class ModifyGroups < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      ALTER TABLE groups rename column day to starts_at;
      ALTER TABLE groups rename column end_time to ends_at;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE groups reame column starts_at to day;
      ALTER TABLE groups rename column ends_at to end_time;
    SQL
  end
end

class AddEndTimeToGroups < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table groups ADD end_time time;
    SQL
  end

  def down
    execute <<-SQL
      alter table groups DROP end_time;
    SQL
  end
end


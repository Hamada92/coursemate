class EndTimeConstraint < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table groups ALTER end_time SET not null;
      alter table groups ADD CONSTRAINT end_time_greater_than_start_time check(end_time > start_time);
    SQL
  end

  def down
    execute <<-SQL
      alter table groups DROP CONSTRAINT end_time_greater_than_start_time;
      alter table groups ALTER end_time DROP not null;
    SQL
  end
end

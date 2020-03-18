class AddCourseConstraint < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table courses ADD check (name ~ '\\A[A-Z0-9]+\\Z');
    SQL
  end

  def down
    execute <<-SQL
      alter table courses drop constraint IF EXISTS courses_name_check1;
    SQL
  end
end

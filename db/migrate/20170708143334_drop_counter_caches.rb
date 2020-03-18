class DropCounterCaches < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      ALTER TABLE groups DROP num_enrollments CASCADE;
      ALTER TABLE universities DROP num_groups CASCADE;
      ALTER TABLE universities DROP num_questions CASCADE;
      ALTER TABLE courses DROP num_groups CASCADE;
      ALTER TABLE courses DROP num_questions CASCADE;
    SQL
  end
end

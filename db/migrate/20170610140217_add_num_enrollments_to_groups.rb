class AddNumEnrollmentsToGroups < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table groups add num_enrollments integer default 0;
      create index num_enrollments_groups on groups(num_enrollments);
    SQL
  end

  def down
    execute <<-SQL
      alter table groups drop IF EXISTS num_enrollments;
    SQL
  end
end

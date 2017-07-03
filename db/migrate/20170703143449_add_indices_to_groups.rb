class AddIndicesToGroups < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create index group_university on groups(university_domain);
      create index group_university_course on groups(course_name, university_domain)
    SQL
  end

  def down
    execute <<-SQL
      DROP index if exists group_university;
      DROP index if exists group_university_course;
    SQL
  end
end

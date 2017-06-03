class CreateCourses < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create table courses (
        name text not null
          check (length(name) > 1),
        university_domain text not null,
        primary key(name, university_domain),
        foreign key(university_domain)
          references universities(domain)
      );
      create index univresities_domain on courses(university_domain);
    SQL
  end

  def down
    execute <<-SQL
      drop table courses;
    SQL
  end
end

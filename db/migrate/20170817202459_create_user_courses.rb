class CreateUserCourses < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create table user_courses (
        user_id int NOT NULL references users(id) on DELETE CASCADE,
        course_name text NOT NULL,
        university_domain text NOT NULL,
        foreign key (course_name, university_domain) references courses(name, university_domain) on DELETE CASCADE,
        primary key(user_id, course_name, university_domain)
      );

      create index user_courses_course_name_university_domain on user_courses(course_name, university_domain);
      create index user_courses_university_domain_course_name_ on user_courses(university_domain, course_name);

    SQL
  end

  def down
    execute <<-SQL
      drop table user_courses;
    SQL
  end
end

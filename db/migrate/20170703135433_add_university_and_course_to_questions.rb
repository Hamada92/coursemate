class AddUniversityAndCourseToQuestions < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table questions ADD university_domain text not null references universities(domain);
      alter table questions ADD course_name text not null;
      alter table questions ADD foreign key(course_name, university_domain) references courses(name, university_domain) on delete cascade;
      alter table questions ADD constraint body_check CHECK(length(body) > 0);
      alter table questions ADD constraint title_check CHECK(length(title) > 0);

      create index question_university on questions(university_domain);
      create index question_university_course on questions(course_name, university_domain)
    SQL
  end

  def down
    execute <<-SQL
      alter table questions DROP university_domain;
      alter table questions DROP course_name;
      DROP index if exists question_university;
      DROP index if exists question_university_course;
      alter table questions DROP constraint body_check;
      alter table questions  DROP constraint title_check;
    SQL
  end
end

class AddNumGroupsQuestionsToCourses < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
    alter table courses ADD num_groups integer default 0;
    create index num_groups_courses on courses(num_groups);
    alter table courses ADD num_questions integer default 0;
    create index num_questions_courses on courses(num_questions);
    SQL
  end

  def down
    execute <<-SQL
      alter table courses DROP num_groups;
      alter table courses DROP num_questions;
    SQL
  end
end

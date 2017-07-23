class CreateQuestionBodies < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create table question_html_bodies (
        body text check(length(body) > 0),
        question_id int references questions(id),
        primary key(question_id)
      )
    SQL
  end

  def down
    execute <<-SQL
      drop table question_html_bodies;
    SQL
  end
end

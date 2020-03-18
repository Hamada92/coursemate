class AddAnswerIdToComments < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL

      ALTER TABLE comments ADD column answer_id int references answers(id);
      ALTER TABLE comments add constraint type_xor check(
        (question_id is not null)::integer +
        (answer_id is not null)::integer +
        (group_id is not null)::integer = 1
      );

      create index comments_answer_id on comments(answer_id);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE comments DROP constraint type_xor;
      DROP INDEX if exists comments_answer_id;
    SQL
  end
end

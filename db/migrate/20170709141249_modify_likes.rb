class ModifyLikes < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      ALTER TABLE likes DROP column IF EXISTS likeable_id;
      ALTER TABLE likes DROP column IF EXISTS likeable_type;
      ALTER TABLE likes add column question_id int references questions(id);
      ALTER TABLE likes add column answer_id int references answers(id);
      ALTER TABLE likes alter column user_id SET NOT NULL;
      CREATE INDEX question_id_likes on likes(question_id);
      CREATE INDEX answer_id_likes on likes(answer_id);

      ALTER TABLE likes add constraint type_xor check(
        (question_id is not null)::integer +
        (answer_id is not null)::integer = 1
      );
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE likes DROP column question_id;
      ALTER TABLE likes DROP column answer_id;
      DROP INDEX IF EXISTS question_id_likes;
      DROP INDEX IF EXISTS answer_id_likes;
      ALTER TABLE likes DROP constraint IF EXISTS type_xor;
    SQL
  end
end

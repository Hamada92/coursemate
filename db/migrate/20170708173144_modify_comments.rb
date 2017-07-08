class ModifyComments < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      ALTER TABLE comments DROP column commentable_id;
      ALTER TABLE comments DROP column commentable_type;
      ALTER TABLE comments add column question_id int references questions(id);
      ALTER TABLE comments add column group_id int references groups(id);
      ALTER TABLE comments alter column user_id SET NOT NULL;
      ALTER TABLE comments add constraint body_check check(length(body) > 0);
    SQL
  end
end

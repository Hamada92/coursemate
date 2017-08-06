class AddCascadesToLikes < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      begin;
        alter table likes drop constraint IF EXISTS fk_rails_1e09b5dabf;

        alter table likes add constraint likes_user_id_fkey
          foreign key (user_id) references users(id) on delete cascade;

        alter table likes drop constraint IF EXISTS likes_answer_id_fkey;

        alter table likes add constraint likes_answer_id_fkey
          foreign key (answer_id) references answers(id) on delete cascade;

        alter table likes drop constraint IF EXISTS likes_question_id_fkey;

        alter table likes add constraint likes_question_id_fkey
          foreign key (question_id) references questions(id) on delete cascade;
    SQL
  end
end

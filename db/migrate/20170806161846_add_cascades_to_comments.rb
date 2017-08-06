class AddCascadesToComments < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      begin;
        alter table comments drop constraint IF EXISTS comments_answer_id_fkey;

        alter table comments add constraint comments_answer_id_fkey
          foreign key (answer_id) references answers(id) on delete cascade;

        alter table comments drop constraint IF EXISTS comments_group_id_fkey;

        alter table comments add constraint comments_group_id_fkey
          foreign key (group_id) references groups(id) on delete cascade;

        alter table comments drop constraint IF EXISTS comments_question_id_fkey;

        alter table comments add constraint comments_question_id_fkey
          foreign key (question_id) references questions(id) on delete cascade;
    SQL
  end
end

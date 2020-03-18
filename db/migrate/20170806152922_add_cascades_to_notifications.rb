class AddCascadesToNotifications < ActiveRecord::Migration[5.0][5.0]
 def up
    execute <<-SQL
      begin;
        alter table notifications drop constraint IF EXISTS notifications_answer_id_fkey;

        alter table notifications add constraint qotifications_answer_id_fkey
          foreign key (answer_id) references answers(id) on delete cascade;

        alter table notifications drop constraint IF EXISTS notifications_comment_id_fkey;

        alter table notifications add constraint notifications_comment_id_fkey
          foreign key (comment_id) references comments(id) on delete cascade;

        alter table notifications drop constraint IF EXISTS notifications_like_id_fkey;

        alter table notifications add constraint notifications_like_id_fkey
          foreign key (like_id) references likes(id) on delete cascade;
    SQL
  end
end

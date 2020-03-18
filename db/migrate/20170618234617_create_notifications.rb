class CreateNotifications < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create sequence notifications_id_seq;
      create table notifications (
        id integer not null default nextval('notifications_id_seq'),
        comment_id integer references comments(id),
        answer_id integer references answers(id),
        like_id integer references likes(id),
        user_id integer references users(id),
        read boolean default false,
        primary key(id)
      );
      create index user_id_notifications on notifications(user_id);
      create index answer_id_notifications on notifications(answer_id);
      create index comment_id_notifications on notifications(comment_id);
      create index like_id_notifications on notifications(like_id);
    SQL
  end

  def down
    execute <<-SQL
      drop table notifications;
      drop sequence notifications_id_seq;
    SQL
  end
end

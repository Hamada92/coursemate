class AddConstraintsToNotifications < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table notifications ADD constraint unqiue_notification_comment unique(comment_id);
      alter table notifications ADD constraint unqiue_notification_answer unique(answer_id);
      alter table notifications ADD constraint unqiue_notification_like unique(like_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table notifications drop constraint unqiue_notification_comment;
      alter table notifications drop constraint unqiue_notification_answer;
      alter table notifications drop constraint unqiue_notification_like;
    SQL
  end
end

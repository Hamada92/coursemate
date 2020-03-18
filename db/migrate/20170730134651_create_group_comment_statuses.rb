class CreateGroupCommentStatuses < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create table group_comment_statuses(
        comment_id int NOT NULL references comments(id) ON DELETE CASCADE,
        user_id int NOT NULL references users(id) ON DELETE CASCADE,
        seen boolean DEFAULT FALSE,
        primary key (comment_id, user_id)
      );

      create index user_comment_id on group_comment_statuses(user_id, comment_id);
      create index comment_seen on group_comment_statuses(seen)
    SQL
  end

  def down
    execute <<-SQL
      drop table group_comment_statuses;
    SQL
  end
end

class AddIndexOnUserSeenCommentStatuses < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create index user_id_seen_comment_statuses on comment_statuses(user_id, seen);
      create index user_id_seen_answers on answers(user_id, seen);
      create index user_id_seen_likes on likes(user_id, seen)
    SQL
  end
end

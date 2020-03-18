class GroupEnrollments < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create table group_enrollments(
        user_id integer references users(id),
        group_id integer references groups(id),
        created_at timestamp,
        primary key(user_id, group_id)
      );
      create index group_enrollments_group_id_user_id on group_enrollments(group_id, user_id);
    SQL
  end

  def down
    execute <<-SQL
      drop table group_enrollments;
    SQL
  end
end

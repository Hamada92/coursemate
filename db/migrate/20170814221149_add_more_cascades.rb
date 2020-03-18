class AddMoreCascades < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      begin;
        alter table group_enrollments drop constraint IF EXISTS group_enrollments_group_id_fkey;
        alter table group_enrollments add constraint group_enrollments_group_id_fkey
          foreign key (group_id) references groups(id) on delete cascade;

        alter table group_enrollments drop constraint IF EXISTS group_enrollments_user_id_fkey;
        alter table group_enrollments add constraint group_enrollments_user_id_fkey
          foreign key (user_id) references users(id) on delete cascade;

    SQL
  end
end

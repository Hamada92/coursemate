class UserOnDeleteConstraint < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      BEGIN;
        alter table groups drop constraint IF EXISTS groups_creator_id_fkey;
        alter table groups add constraint groups_creator_id_fkey
          foreign key (creator_id) references users(id) on delete SET NULL;

        alter table questions drop constraint IF EXISTS fk_rails_047ab75908;
        alter table questions add constraint questions_user_id_fkey
          foreign key (user_id) references users(id) on delete SET NULL;

        alter table answers drop constraint IF EXISTS fk_rails_584be190c2;
        alter table answers add constraint answers_user_id_fkey
          foreign key (user_id) references users(id) on delete SET NULL;

        alter table comments add constraint comments_user_id_fkey
          foreign key (user_id) references users(id) on delete CASCADE;
    SQL
  end

  def down
    execute <<-SQL
      alter table groups drop constraint IF EXISTS groups_creator_id_fkey;
      alter table questions drop constraint IF EXISTS questions_user_id_fkey;
      alter table answers drop constraint IF EXISTS answers_user_id_fkey;
      alter table comments drop constraint IF EXISTS comments_user_id_fkey;
    SQL
  end
end

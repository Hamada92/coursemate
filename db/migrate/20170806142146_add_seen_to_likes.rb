class AddSeenToLikes < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table likes add column seen boolean DEFAULT FALSE;
      create index likes_seen on likes(seen);
    SQL
  end

  def down
    execute <<-SQL
      alter table likes drop column seen;
    SQL
  end
end

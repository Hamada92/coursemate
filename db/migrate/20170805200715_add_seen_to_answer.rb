class AddSeenToAnswer < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table answers add column seen boolean DEFAULT FALSE;
      create index seen_answers on answers(seen)
    SQL
  end

  def down
    execute <<-SQL
      alter table answers drop column seen;
    SQL
  end
end

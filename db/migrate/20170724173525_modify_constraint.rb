class ModifyConstraint < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table groups drop constraint IF EXISTS groups_starts_at_check;
      alter table groups drop constraint IF EXISTS starts_at_is_today_or_later;
    SQL
  end
end

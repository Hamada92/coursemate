class RemoveTimeConstraint < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table groups drop constraint groups_starts_at_check1;
    SQL
  end
end

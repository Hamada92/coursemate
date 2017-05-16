class AddStatusToGroups < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      alter table groups
        ADD status varchar(20) check(status IN ('active', 'cancelled', 'completed'));
      create index groups_status on groups(status);
    SQL
  end
end

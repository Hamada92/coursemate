class CheckEndTimeAndStartTime < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table groups add constraint ends_at_greater_than_starts_at CHECK(ends_at > starts_at);
    SQL
  end
end

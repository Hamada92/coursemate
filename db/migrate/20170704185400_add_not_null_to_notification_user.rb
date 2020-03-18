class AddNotNullToNotificationUser < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      ALTER TABLE notifications alter column user_id set not null;
    SQL
  end
end

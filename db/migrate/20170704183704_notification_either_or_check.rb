class NotificationEitherOrCheck < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table notifications add constraint type_xor check(
        (comment_id is not null)::integer +
        (answer_id is not null)::integer +
        (like_id is not null)::integer = 1
      )
    SQL
  end

  def down
    execute <<-SQL
      alter table notifications drop constraint type_xor;
    SQL
  end
end

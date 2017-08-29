class AddSubscribedToUsers < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table users ADD column subscribed boolean default true;
      create index users_subscribed on users(subscribed);
    SQL
  end
end

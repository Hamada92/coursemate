class AddUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :int
    add_index :comments, :user_id
  end
end

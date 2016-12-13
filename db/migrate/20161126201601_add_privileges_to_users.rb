class AddPrivilegesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :privileges, :integer, default: 0
  end
end

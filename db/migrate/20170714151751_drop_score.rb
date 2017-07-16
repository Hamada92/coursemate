class DropScore < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :score, :int
  end
end

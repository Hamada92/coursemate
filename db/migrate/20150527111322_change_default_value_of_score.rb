class ChangeDefaultValueOfScore < ActiveRecord::Migration
  def change
    change_column :users, :score, :int, default: 0
  end
end

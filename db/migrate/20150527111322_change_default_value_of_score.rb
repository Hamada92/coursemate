class ChangeDefaultValueOfScore < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :score, :int, default: 0
  end
end

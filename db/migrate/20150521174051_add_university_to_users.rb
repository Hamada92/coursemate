class AddUniversityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :university, :string
    add_index :users, :university
  end
end

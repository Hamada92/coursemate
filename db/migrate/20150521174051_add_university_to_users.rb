class AddUniversityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :university, :string
    add_index :users, :university
  end
end

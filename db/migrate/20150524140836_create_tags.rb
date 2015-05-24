class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :university

      t.timestamps null: false
    end
    add_index :tags, :name
    add_index :tags, :university
  end
end

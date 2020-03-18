class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :likes, :users
  end
end

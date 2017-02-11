class CreateGroupTags < ActiveRecord::Migration[5.0]
  def change
    create_table :group_tags do |t|
      t.string :name
      t.string :university

      t.timestamps
    end
    add_index :group_tags, :name
    add_index :group_tags, :university
  end
end

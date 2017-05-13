class AddIndexToTags < ActiveRecord::Migration[5.0]
  def change
    add_index :tags, [:name, :category, :university]
    add_index :tags, [:university, :category]
  end
end

class RemoveIndexesFromTags < ActiveRecord::Migration[5.0][5.0]
  def change
    remove_index :tags, :category
    remove_index :tags, :name
  end
end

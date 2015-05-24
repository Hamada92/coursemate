class AddTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :type, :string
    add_index :tags, :type
  end
end

class AddTypeToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :type, :string
    add_index :tags, :type
  end
end

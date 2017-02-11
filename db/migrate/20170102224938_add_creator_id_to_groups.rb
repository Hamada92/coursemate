class AddCreatorIdToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :creator_id, :integer
    add_index :groups, :creator_id
  end
end

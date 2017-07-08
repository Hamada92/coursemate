class CreateGroupIndices < ActiveRecord::Migration[5.0]
  def change
    create_view :group_indices
  end
end

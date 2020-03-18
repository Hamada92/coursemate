class UpdateGroupIndicesToVersion3 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :group_indices, version: 3, revert_to_version: 2
  end
end

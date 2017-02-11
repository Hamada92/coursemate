class RemoveEndTimeFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :end_time
  end
end

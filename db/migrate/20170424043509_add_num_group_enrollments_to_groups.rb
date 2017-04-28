class AddNumGroupEnrollmentsToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :num_group_enrollments, :int, default: 0
  end
end

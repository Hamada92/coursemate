class AddDateToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :date, :date
    add_column :groups, :start_time, :string
    add_column :groups, :end_time, :string
  end
end

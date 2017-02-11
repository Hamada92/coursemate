class AddTimeAndPlaceToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :seats, :integer
    add_column :groups, :location, :string
  end
end

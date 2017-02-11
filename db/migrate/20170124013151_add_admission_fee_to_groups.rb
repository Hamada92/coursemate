class AddAdmissionFeeToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :admission_fee, :int
  end
end

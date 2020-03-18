class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :tags, :type, :category
  end
end

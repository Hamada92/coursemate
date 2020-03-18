class RenameGroupIndicesView < ActiveRecord::Migration[5.0][5.0]
  def change
    execute <<-sql
      ALTER VIEW group_indices RENAME TO group_indices_unmaterialized;
    sql
  end
end

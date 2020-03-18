class CreateGroupIndicesWithExpiry < ActiveRecord::Migration[5.0][5.0]
  def change
    execute <<-sql
      create table group_indices_with_expiry as
      SELECT *,
        false as dirty
      from group_indices_unmaterialized
    sql
  end
end

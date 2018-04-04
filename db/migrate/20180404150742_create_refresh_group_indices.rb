class CreateRefreshGroupIndices < ActiveRecord::Migration[5.0]
  def up
    execute <<-sql
      create or replace function refresh_group_indices_with_expiry_now(g_id integer) returns void
        security definer
        language 'plpgsql' as $$
        begin
          delete from group_indices_with_expiry gi
          where gi.id = g_id;

          insert into group_indices_with_expiry
          select *, false
            from group_indices_unmaterialized gi
            where gi.id = g_id;
        end
        $$;
    sql
  end

  def down
    execute <<-sql
      DROP FUNCTION refresh_group_indices_with_expiry_now(integer)
    sql
  end
end

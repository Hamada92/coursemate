class InvalidateFunction < ActiveRecord::Migration[5.0]
  def up
    execute <<-sql
      create or replace function invalidate_group_indices_row(g_id integer) returns void
      security definer
      language 'plpgsql' as $$
      declare u_updates integer;
      begin
        update group_indices_with_expiry gi 
        set dirty=true where gi.id = g_id;
        return;
      end
      $$;
    sql
  end

  def down
    execute <<-sql 
      DROP FUNCTION invalidate_group_indices_row(integer);
    sql
  end
end

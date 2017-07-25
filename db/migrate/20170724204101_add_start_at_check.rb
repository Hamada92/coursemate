class AddStartAtCheck < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table groups ADD CHECK(starts_at::date >= localtimestamp::date) NOT VALID;
      alter table groups ADD CHECK(starts_at::time >= localtimestamp::time ) NOT VALID
    SQL
  end
end

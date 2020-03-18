class CreateUniversities < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      create table universities (
        domain text not null,
        name text not null,
        country text not null,
        primary key (domain),
        unique(name, country)
      );
    SQL
  end

  def down
    execute <<-SQL
      drop table universities;
    SQL
  end
end

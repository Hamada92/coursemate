class CreateUniversities < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create table universities (
        domain text not null,
        name text not null,
        country text not null,
        unique(name, country),
        primary key (domain)
      );      
    SQL
  end

  def down
    execute <<-SQL
      drop table universities;
    SQL
  end
end

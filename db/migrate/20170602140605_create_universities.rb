class CreateUniversities < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create table universities (
        domain varchar(50) not null,
        name varchar(50) not null,
        country varchar(30) not null,
        unique(name, country),
        primary key (domain)
      );      
    SQL
  end

  def down
    execute<<-SQL
      drop table universities
    SQL
  end
end

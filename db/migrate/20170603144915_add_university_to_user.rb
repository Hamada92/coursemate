class AddUniversityToUser < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      alter table users ADD university_domain text references universities(domain);
      alter table users DROP IF EXISTS university;
      alter table users ADD CONSTRAINT email_length check(length(email) > 4);
      alter table users ALTER email DROP default;
      alter table users ADD CONSTRAINT username_length check(length(username) > 0);
    SQL
  end

  def down
    execute <<-SQL
      alter table users DROP university_domain;
      alter table users DROP CONSTRAINT email_length;
      alter table users DROP CONSTRAINT username_length;
    SQL
  end

end

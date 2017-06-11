class CreateGroups < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create sequence groups_id_seq;
      create table groups (
        id integer not null default nextval('groups_id_seq'),
        university_domain text not null,
        course_name text not null,
        creator_id integer references users(id),
        status varchar(20) check(status IN ('active', 'cancelled', 'completed')),
        foreign key (university_domain) references universities(domain),
        foreign key (course_name, university_domain) references courses(name, university_domain) on delete cascade,
        seats integer CHECK(seats > 1),
        location text not null CHECK(length(location) > 1),
        day date not null CONSTRAINT day_at_leat_today CHECK(day >= current_date),
        title text not null CHECK(length(title) > 0),
        description text not null CHECK(length(description) > 0),
        start_time time not null,
        created_at timestamp,
        updated_at timestamp,
        primary key (id)

      );
      create index groups_status on groups(status);
      create index groups_creator_id on groups(creator_id);
    SQL
  end

  def down
    execute <<-SQL
      drop table groups;
      drop sequence groups_id_seq;
      
    SQL
  end
end

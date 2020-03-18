class AddNumQuestionsToUniversities < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      alter table universities ADD num_questions integer default 0;
      create index num_questions_universities on universities(num_questions);
    SQL
  end

  def down
    execute <<-SQL
      alter table universities DROP num_questions;
    SQL
  end
end

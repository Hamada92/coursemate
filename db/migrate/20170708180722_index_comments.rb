class IndexComments < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      create index question_id_comments on comments(question_id);
      create index group_id_comments on comments(group_id)
    SQL
  end
end

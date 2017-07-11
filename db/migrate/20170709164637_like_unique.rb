class LikeUnique < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      ALTER TABLE likes add constraint unique_question_user unique(user_id, question_id);
      ALTER TABLE likes add constraint unique_answer_user unique(user_id, answer_id)
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE likes drop constraint unique_answer_user;
      ALTER TABLE likes drop constraint unique_question_user
    SQL
  end
end

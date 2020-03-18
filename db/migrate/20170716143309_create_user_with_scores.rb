class CreateUserWithScores < ActiveRecord::Migration[5.0][5.0]
  def change
    create_view :user_with_scores
  end
end

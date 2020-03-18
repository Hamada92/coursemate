class AddNumLikesToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :num_likes, :int, default: 0
  end
end

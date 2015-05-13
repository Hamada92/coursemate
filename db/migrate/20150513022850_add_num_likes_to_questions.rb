class AddNumLikesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :num_likes, :int, default: 0
  end
end

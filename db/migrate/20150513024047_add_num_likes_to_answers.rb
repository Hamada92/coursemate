class AddNumLikesToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :num_likes, :int, default: 0
  end
end

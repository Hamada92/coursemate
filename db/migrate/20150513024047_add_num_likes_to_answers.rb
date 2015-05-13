class AddNumLikesToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :num_likes, :int, default: 0
  end
end

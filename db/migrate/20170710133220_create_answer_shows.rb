class CreateAnswerShows < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :num_likes
    create_view :answer_shows
  end
end

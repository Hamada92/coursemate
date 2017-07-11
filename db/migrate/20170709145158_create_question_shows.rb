class CreateQuestionShows < ActiveRecord::Migration[5.0]
  def change
    create_view :question_shows
  end
end

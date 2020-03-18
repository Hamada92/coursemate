class UpdateQuestionShowsToVersion8 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :question_shows, version: 8, revert_to_version: 7
  end
end

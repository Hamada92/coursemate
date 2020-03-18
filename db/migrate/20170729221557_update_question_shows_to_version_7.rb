class UpdateQuestionShowsToVersion7 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :question_shows, version: 7, revert_to_version: 6
  end
end

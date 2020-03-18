class UpdateQuestionShowsToVersion9 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :question_shows, version: 9, revert_to_version: 8
  end
end

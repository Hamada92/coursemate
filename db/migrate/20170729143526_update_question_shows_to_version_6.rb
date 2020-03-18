class UpdateQuestionShowsToVersion6 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :question_shows, version: 6, revert_to_version: 5
  end
end

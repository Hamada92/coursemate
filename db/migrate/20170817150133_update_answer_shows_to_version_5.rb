class UpdateAnswerShowsToVersion5 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :answer_shows, version: 5, revert_to_version: 4
  end
end

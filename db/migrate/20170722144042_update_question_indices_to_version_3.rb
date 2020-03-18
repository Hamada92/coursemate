class UpdateQuestionIndicesToVersion3 < ActiveRecord::Migration[5.0][5.0]
  def change
    update_view :question_indices, version: 3, revert_to_version: 2
  end
end

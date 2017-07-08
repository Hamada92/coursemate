class CreateQuestionIndices < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :num_answers
    create_view :question_indices
  end
end

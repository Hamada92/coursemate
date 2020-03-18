class AddNumAnswersToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :num_answers, :int, default: 0

  end
end

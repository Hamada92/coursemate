class AddNumAnswersToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :num_answers, :int, default: 0

  end
end

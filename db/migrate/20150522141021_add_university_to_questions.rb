class AddUniversityToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :university, :string
    add_index :questions, :university
  end
end

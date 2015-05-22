class AddUniversityToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :university, :string
    add_index :questions, :university
  end
end

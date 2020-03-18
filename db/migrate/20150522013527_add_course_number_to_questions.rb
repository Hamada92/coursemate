class AddCourseNumberToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :course_number, :integer
    add_index :questions, :course_number
  end
end

class AddCourseNumberToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :course_number, :integer
    add_index :questions, :course_number
  end
end

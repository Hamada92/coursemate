class AddCourseNameToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :course_name, :string
    add_index :questions, :course_name
  end
end

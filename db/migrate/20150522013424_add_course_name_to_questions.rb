class AddCourseNameToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :course_name, :string
    add_index :questions, :course_name
  end
end

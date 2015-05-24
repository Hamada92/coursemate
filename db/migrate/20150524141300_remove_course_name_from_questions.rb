class RemoveCourseNameFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :course_name
    remove_column :questions, :course_number
    remove_column :questions, :university
  end
end

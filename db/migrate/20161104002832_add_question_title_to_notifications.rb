class AddQuestionTitleToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :question_title, :string
  end
end

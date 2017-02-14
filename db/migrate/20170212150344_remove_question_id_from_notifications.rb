class RemoveQuestionIdFromNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :question_id
  end
end

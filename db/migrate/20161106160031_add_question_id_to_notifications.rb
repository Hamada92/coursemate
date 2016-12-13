class AddQuestionIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :question_id, :int
  end
end

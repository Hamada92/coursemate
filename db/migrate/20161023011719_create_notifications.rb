class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :notifier, polymorphic: true, index: true
      t.references :user
      
      t.timestamps
    end
  end
end

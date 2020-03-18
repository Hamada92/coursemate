class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :users
  end
end

class RemoveHtmlBodies < ActiveRecord::Migration[5.0][5.0]
  def change
    drop_table :question_html_bodies
  end
end

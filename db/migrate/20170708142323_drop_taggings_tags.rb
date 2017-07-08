class DropTaggingsTags < ActiveRecord::Migration[5.0]
  def change
    drop_table :tags ,force: :cascade
    drop_table :taggings
  end
end

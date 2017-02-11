class CreateGroupTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :group_taggings do |t|
      t.references :group, index: true
      t.references :group_tag, index: true

      t.timestamps
    end

    add_foreign_key :group_taggings, :groups
    add_foreign_key :group_taggings, :group_tags
  end
end

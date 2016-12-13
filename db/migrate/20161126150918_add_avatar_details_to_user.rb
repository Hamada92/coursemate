class AddAvatarDetailsToUser < ActiveRecord::Migration[5.0]
  def change

    add_column :users, :avatar, :string
    add_column :users, :avatar_temp, :string
    add_column :users, :processing_avatar, :boolean

    add_column :users, :crop_x, :float
    add_column :users, :crop_y, :float
    add_column :users, :crop_w, :float
    add_column :users, :crop_h, :float

  end
end

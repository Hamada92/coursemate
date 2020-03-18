class CreateGroupShows < ActiveRecord::Migration[5.0][5.0]
  def change
    create_view :group_shows
  end
end

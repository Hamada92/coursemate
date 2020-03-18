class UpdateUserWithScoresToVersion2 < ActiveRecord::Migration[5.0][5.0]
  def change
    #replace because other views depend on this view, so can't drop
    replace_view :user_with_scores, version: 2, revert_to_version: 1
  end
end

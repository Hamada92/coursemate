class DropCounterCachesLike < ActiveRecord::Migration[5.0][5.0]
  def up
    execute <<-SQL
      ALTER TABLE questions DROP num_likes CASCADE;
    SQL
  end
end

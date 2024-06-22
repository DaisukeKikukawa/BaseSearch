class RenameGameStartedAt < ActiveRecord::Migration[7.1]
  def change
    rename_column :games, :game_started_at, :start_time
  end
end

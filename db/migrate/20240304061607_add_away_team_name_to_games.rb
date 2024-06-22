class AddAwayTeamNameToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :away_team_name, :string
  end
end

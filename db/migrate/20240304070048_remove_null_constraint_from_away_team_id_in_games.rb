class RemoveNullConstraintFromAwayTeamIdInGames < ActiveRecord::Migration[7.1]
  def change
    change_column_null :games, :away_team_id, true
  end
end

class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @total_games = Game.where("(home_team_id = ? OR away_team_id = ?) AND extract(year from start_time) = ?",
                        @team.id, @team.id, Time.now.year).count
  end

  def search_category
    @team_categories = TeamCategory.all
  end
end

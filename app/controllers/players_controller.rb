class PlayersController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @players = @team.players
    @infielders = @players.infielders
    @outfielders = @players.outfielders
    @pitchers = @players.pitchers
    @catchers = @players.catchers
    @etces = @players.etc
  end
end

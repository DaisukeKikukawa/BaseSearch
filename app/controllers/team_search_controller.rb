class TeamSearchController < ApplicationController
  def index
    @team_categories = TeamCategory.all
  end

  def search
    @team_category = TeamCategory.find(params[:team_category_id])
    @teams = @team_category.teams
  end
end

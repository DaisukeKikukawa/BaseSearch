class TournamentsController < ApplicationController
  def index
    year = params[:year].presence || Date.current.year
    month = params[:month].presence || Date.current.month
    @month = Date.new(year.to_i, month.to_i)
    @tournament_records = TournamentRecord.where(started_at: @month.beginning_of_month..@month.end_of_month)
  end

  def show
    @tournament = Tournament.find(params[:id])
  end
end

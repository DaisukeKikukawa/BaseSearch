class GamesController < ApplicationController
  before_action :set_games

  def index
  end

  def show
    @game = Game.find(params[:id])
  end

  def calendar
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def games_by_date(games)
    date = get_date_from_params

    start_date = date.beginning_of_month
    end_date = date.end_of_month

    @games_by_date = (start_date..end_date).each_with_object({}) do |date, hash|
      hash[date] = games.select { |game| game.start_time.to_date == date }
    end
  end

  def get_date_from_params
    if params["month"] && params["year"]
      Date.new(params["year"].to_i, params["month"].to_i, 1)
    elsif params[:date].present?
      params[:date].to_date
    else
      Date.today
    end
  end

  def games_by_month(games)
    if params[:date].present?
      date = params[:date].to_date
      @year_and_month = Time.zone.local(date.year, date.month)
    else
      year = params[:year].presence || Date.current.year
      month = params[:month].presence || Date.current.month
      @year_and_month = Time.zone.local(year.to_i, month.to_i)
    end
    games.where(start_time: @year_and_month.beginning_of_month..@year_and_month.end_of_month)
  end

  def games_by_year(games)
    if params[:date].present?
      date = params[:date].to_date
      @year = Time.zone.local(date.year)
    else
      year = params[:year].presence || Date.current.year
      @year = Time.zone.local(year.to_i)
    end
    games.where(start_time: @year.beginning_of_year..@year.end_of_year)
  end

  def set_games
    if params[:team_id]
      set_team_games
    elsif params[:tournament_id]
      set_tournament_games
    else
      @games = Game.all
      games_by_month = games_by_month(@games)
      games_by_date(games_by_month)
    end
  end

  def set_team_games
    @team = Team.find(params[:team_id])
    @games = Game.from_team(params[:team_id])
    games_by_year = games_by_year(@games)
    @games_by_date = games_by_year.group_by { |game| game.start_time.to_date }.sort.to_h
  end

  def set_tournament_games
    tournament_record_id = params[:tournament_id]
    @tournament_record = TournamentRecord.find(tournament_record_id.to_i)
    games = TournamentRecord.find(tournament_record_id).games
    @games = params[:filter] == "result" ? games.finished : games.upcoming + games.live
    @games_by_date = @games.group_by { |game| game.start_time.to_date }.sort.to_h
  end
end

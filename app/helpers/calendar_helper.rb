module CalendarHelper
  def url_for_year(start_date, year)
    start_day = start_date.strftime("%d").to_i
    # うるう年の2月29日の場合、2月28日に変更
    start_day -= 1  if start_date.leap? && start_day == 29
    target_date = Date.new(year, start_date.strftime("%m").to_i, start_day)
    games_calendar_path(
      start_date: target_date, team_id: params[:team_id],
      tournament_id: params[:tournament_id], filter: params[:filter]
    )
  end

  def url_for_month(start_date, month)
    target_date = Date.new(start_date.strftime("%Y").to_i, month, 1)
    games_calendar_path(
      start_date: target_date, team_id: params[:team_id],
      tournament_id: params[:tournament_id], filter: params[:filter]
    )
  end

  def active_year_class?(start_date, year)
    year.to_i == start_date.to_date.strftime("%Y").to_i ? "active" : ""
  end

  def active_month_class?(start_date, month)
    month.to_i == start_date.to_date.strftime("%m").to_i ? "active" : ""
  end

  def date_filter_path(date, params)
    if params[:team_id]
      team_games_path(@team, date:)
    elsif params[:tournament_id]
      tournament_games_path(@tournament_record, date:, filter: params[:filter])
    else
      games_path(date:)
    end
  end
end

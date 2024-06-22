module TournamentsHelper
  def has_games?(tournament_record)
    tournament_record.games.present?
  end
end

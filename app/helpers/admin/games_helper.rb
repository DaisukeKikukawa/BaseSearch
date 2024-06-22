module Admin::GamesHelper
  def select_form_display_name(item)
    if item.is_a?(TournamentRecord)
      "#{item.tournament.name} / #{item.name}"
    else
      item.name
    end
  end
end

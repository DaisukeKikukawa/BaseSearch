module TeamSearchHelper
  def team_category_has_teams?(team_category)
    team_category.teams.present?
  end

  def display_team_category(team_category)
    if team_category_has_teams?(team_category)
      link_to team_category.name,
              team_search_search_path(team_category_id: team_category.id),
              class: "category_a text-decoration-none text-black d-block"
    else
      content_tag(:div, team_category.name, class: "category_a text-black opacity-50")
    end
  end
end

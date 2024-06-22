module TeamsHelper
  def team_icon_style(team)
    team.team_image.present? ? "margin-top: -50px; position: relative; z-index: 3" : "margin-top: 25px;"
  end
end

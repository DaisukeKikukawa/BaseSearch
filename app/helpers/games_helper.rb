module GamesHelper
  def is_display_calendar?(controller_name)
    controller_name == 'games'
  end

  def game_status(game)
    current_time = Time.current

    if current_time < game.start_time
      { class: 'text-dark', text: '試合前', status: 'upcoming' }
    elsif current_time > game.start_time + 2.hours
      { class: 'text-primary', text: '試合終了', status: 'finished' }
    else
      { class: 'text-danger', text: '試合中', status: 'live' }
    end
  end

  def nav_link_active?(filter_type)
    params[:filter] == filter_type ? 'nav-link active text-dark' : 'nav-link text-dark'
  end

  def display_game_info(game)
    case game_status(game)[:status]
    when "upcoming"
      game.start_time.strftime("%H:%M")
    when "live"
      "VS"
    else
      if game.home_team_score && game.away_team_score
        "#{game.home_team_score} - #{game.away_team_score}"
      end
    end
  end

  def end_time(game)
    game.start_time + 2.hours
  end

  def game_article_result?(game)
    game.game_articles.any? { |article| article.article_type == 'match_results' }
  end

  def game_article_highlights?(game)
    game.game_articles.any? { |article| article.article_type == 'highlights' } &&
    Time.current < game.start_time.end_of_day
  end

  def button_label(game)
    return '試合詳細' if game_article_result?(game)
    return '見どころ' if game_article_highlights?(game)
    return '試合詳細' if game.game_articles.any?
  end

  def formatted_away_team_name(game)
    if game.away_team.present?
      if game.away_teamable_type == "UnionTeam"
        wrap_and_ellipsizing_text(game.away_team.name, 6, 11).html_safe
      else
        link_to wrap_and_ellipsizing_text(game.away_team.name, 6, 11).html_safe,
              team_path(game.away_team),
              class: 'team-link'
      end
    else
      wrap_and_ellipsizing_text(game.away_team_name, 6, 11).html_safe
    end
  end

  def tag_class(tag_type)
    case tag_type
    when 'featured'
      'tag-color-featured'
    when 'final'
      'tag-color-final'
    when 'semi_final'
      'tag-color-semi-final'
    when 'live'
      'tag-color-live'
    when 'movie'
      'tag-color-movie'
    end
  end
end

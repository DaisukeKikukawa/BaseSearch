class WordpressArticlesController < ApplicationController
  include Pagy::Backend
  before_action :set_team

  def index
    # binding.pry
    # @wp_articles = WpArticle.joins(:article_teams).where(article_teams: { team_id: @team.id })
    slug_name = @team.slugs.map(&:name).join(", ")
    @pagy, @wp_articles = pagy(WpArticle.joins(:slugs).where(slugs: { name: slug_name }), items: 1)
    # @wp_articles = WpArticle.joins(:slugs).where(slugs: { name: slug_name }).page(params[:page])
    # binding.pry
  end
end

private

def set_team
  @team = Team.find(params[:team_id])
end

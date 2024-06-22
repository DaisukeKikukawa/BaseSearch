class FetchController < ApplicationController
  # def fetch_slug
  #   SlugFetcher.slug_fetch
  #   # redirect_to request.referrer, notice: 'Slug情報を同期しました'
  #   # @slugs = Slug.all
  #   redirect_to new_admin_team_path, notice: 'Slug情報を同期しました'
  # end

  # def fetch_wp_article
  #   WpArticleFetcher.fetch_and_save
  #   redirect_to new_admin_team_path, notice: 'Slug情報を同期しました'
  # end
  def fetch_slugs_and_articles
    #先にスラッグを作成
    SlugFetcher.slug_fetch
    WpArticleFetcher.fetch_and_save
    redirect_to request.referrer, notice: '記事とSlug情報を同期しました'
  end
end

require 'faraday'
require 'json'

class WpArticleFetcher
  def self.fetch_and_save

    conn = Faraday.new(url: 'https://kiryu910.jp') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    # page = 1
    # while true
      # response = conn.get "/wp-json/wp/v2/posts?per_page=100&page=#{page}"
      response = conn.get "/wp-json/wp/v2/posts"
      # break unless response.success?
      parsed_articles = JSON.parse(response.body)

      parsed_articles.each do |article|
        wp_article = WpArticle.find_or_initialize_by(wp_id: article['id'])
        wp_article.title = article['title']['rendered']
        wp_article.article_url = article['link']
        wp_article.thumbnail_url = article.dig('yoast_head_json', 'og_image', 0, 'url')
        wp_article.published_at = article['date']
        if article['status'] != 'publish'
          wp_article.is_published = false
        end

        # WpArticleSlugテーブルへの保存
        slug_name = article['slug']
        slug_id = Slug.find_by(name: slug_name).id
        WpArticleSlug.find_or_create_by(wp_article_id: wp_article.id, slug_id: slug_id)

        wp_article.save!
      end
      # page += 1
    # end
  end
end

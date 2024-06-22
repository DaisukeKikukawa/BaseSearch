require 'faraday'
require 'json'

class SlugFetcher
  # Slugテーブルへの保存メソッド
  def self.slug_fetch
    # binding.pry

    conn = Faraday.new(url: 'https://kiryu910.jp') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    # page = 1
    # loop do
      # response = conn.get "/wp-json/wp/v2/posts?per_page=100&page=#{page}"
      response = conn.get "/wp-json/wp/v2/posts"
      # break unless response.success?

      articles = JSON.parse(response.body)

      articles.each do |article|
        # binding.pry
        slug_name = article['slug']
        Slug.find_or_create_by(name: slug_name)  # スラッグをデータベースに保存
        # binding.pry
      end

      # page += 1  # 次のページへ
    # end

  end
end

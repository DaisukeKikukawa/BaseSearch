json.extract! article, :id, :title, :content, :created_at, :updated_at
json.url admin_game_article_url(article.game, article, format: :json)

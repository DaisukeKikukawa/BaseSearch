class Slug < ApplicationRecord
  # Team モデルとの関連付け
  has_many :team_slugs
  has_many :teams, through: :team_slugs

  # WpArticle モデルとの関連付け
  has_many :wp_article_slugs
  has_many :wp_articles, through: :wp_article_slugs
end

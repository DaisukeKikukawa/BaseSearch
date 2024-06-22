class WpArticle < ApplicationRecord
  has_many :article_teams
  has_many :teams, through: :article_teams
  # Slug モデルとの関連付け
  has_many :wp_article_slugs
  has_many :slugs, through: :wp_article_slugs
end

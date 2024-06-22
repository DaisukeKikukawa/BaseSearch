class WpArticleSlug < ApplicationRecord
  belongs_to :wp_article
  belongs_to :slug
end

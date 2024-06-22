class ArticleTeam < ApplicationRecord
  belongs_to :wp_article
  belongs_to :team
end

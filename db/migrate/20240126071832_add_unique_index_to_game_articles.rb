class AddUniqueIndexToGameArticles < ActiveRecord::Migration[7.1]
  def change
    add_index :game_articles, [:game_id, :article_type], unique: true
  end
end

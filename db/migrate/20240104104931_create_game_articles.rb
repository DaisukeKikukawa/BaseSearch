class CreateGameArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :game_articles do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :article_type, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

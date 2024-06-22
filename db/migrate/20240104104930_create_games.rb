class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.datetime :game_started_at, null: false
      t.references :ground, null: false, foreign_key: true
      t.references :tournament_record, null: false, foreign_key: true
      t.references :home_team, null: false, foreign_key: { to_table: :teams }
      t.references :away_team, null: false, foreign_key: { to_table: :teams }
      t.integer :tag_type
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreateTournamentRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :tournament_records do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :ground, null: false, foreign_key: true
      t.date :startd_at, null: false
      t.date :end_at, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

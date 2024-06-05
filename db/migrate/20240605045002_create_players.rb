class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name, null: false
      t.string :kana, null: false
      t.integer :position, null: false
      t.integer :uniform_number
      t.integer :handedness, null: false
      t.integer :handedness_bat, null: false
      t.string :alma_mater, null: false
      t.string :catchphrase
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

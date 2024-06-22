class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :page_path
      t.references :team_category, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreateTeamCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :team_categories do |t|
      t.string :name, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreateTournaments < ActiveRecord::Migration[7.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

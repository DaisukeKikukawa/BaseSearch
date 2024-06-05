class CreateGrounds < ActiveRecord::Migration[7.1]
  def change
    create_table :grounds do |t|
      t.string :name, null: false
      t.string :link_url
      t.string :administrative_organization
      t.string :tel
      t.string :address, null: false
      t.string :image
      t.string :google_map_url
      t.string :train_and_walk_access
      t.string :car_access
      t.string :bus_access
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

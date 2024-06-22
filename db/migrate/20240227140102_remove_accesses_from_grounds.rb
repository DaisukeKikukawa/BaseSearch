class RemoveAccessesFromGrounds < ActiveRecord::Migration[7.1]
  def change
    remove_column :grounds, :train_and_walk_access, :string
    remove_column :grounds, :car_access, :string
    remove_column :grounds, :bus_access, :string

    add_column :grounds, :access, :string
  end
end

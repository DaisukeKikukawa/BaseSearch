class AddSportToGrounds < ActiveRecord::Migration[7.1]
  def change
    add_column :grounds, :sport, :string, null: false
  end
end

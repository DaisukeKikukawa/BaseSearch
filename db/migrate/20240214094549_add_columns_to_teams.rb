class AddColumnsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :facebook_url, :string
    add_column :teams, :instagram_url, :string
    add_column :teams, :x_url, :string
    add_column :teams, :email, :string
  end
end

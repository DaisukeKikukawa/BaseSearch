class AddSubPositionToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :sub_positions, :string
  end
end

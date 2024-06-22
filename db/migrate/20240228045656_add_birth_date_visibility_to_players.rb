class AddBirthDateVisibilityToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :birth_date_visibility, :boolean, default: false, null: false
  end
end

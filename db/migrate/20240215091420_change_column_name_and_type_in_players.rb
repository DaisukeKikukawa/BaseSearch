class ChangeColumnNameAndTypeInPlayers < ActiveRecord::Migration[7.1]
  def change
    rename_column :players, :uniform_number, :birth_date
    change_column :players, :birth_date, :date
  end
end

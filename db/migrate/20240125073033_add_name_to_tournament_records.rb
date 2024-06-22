class AddNameToTournamentRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :tournament_records, :name, :string, null: false
  end
end

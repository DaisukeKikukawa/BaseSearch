class DeleteGroundIdAtColumnToTournamentRecords < ActiveRecord::Migration[7.1]
  def change
    remove_column :tournament_records, :ground_id
  end
end

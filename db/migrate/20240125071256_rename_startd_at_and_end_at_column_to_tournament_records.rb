class RenameStartdAtAndEndAtColumnToTournamentRecords < ActiveRecord::Migration[7.1]
  def change
    rename_column :tournament_records, :startd_at, :started_at
    rename_column :tournament_records, :end_at, :ended_at
  end
end

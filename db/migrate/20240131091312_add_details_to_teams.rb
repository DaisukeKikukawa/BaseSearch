class AddDetailsToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :recruitment_position, :string
    add_column :teams, :slogan_content, :text
    add_column :teams, :team_summary, :text
    add_column :teams, :school_name, :string, null: false
    add_column :teams, :representative_name, :string
    add_column :teams, :coach_name, :string
    add_column :teams, :activity_base, :string
    add_column :teams, :activity_day, :string
    add_column :teams, :historical_records, :text
  end
end

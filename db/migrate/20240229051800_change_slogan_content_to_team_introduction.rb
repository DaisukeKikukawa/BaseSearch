class ChangeSloganContentToTeamIntroduction < ActiveRecord::Migration[7.1]
  def change
    rename_column :teams, :slogan_content, :team_introduction
  end
end

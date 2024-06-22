class RemovePagePathFromTeams < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :page_path, :string
  end
end

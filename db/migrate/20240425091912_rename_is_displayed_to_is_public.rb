class RenameIsDisplayedToIsPublic < ActiveRecord::Migration[7.1]
  def change
    rename_column :grounds, :is_displayed, :is_public
  end
end

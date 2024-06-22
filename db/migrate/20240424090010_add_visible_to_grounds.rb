class AddVisibleToGrounds < ActiveRecord::Migration[7.1]
  def change
    add_column :grounds, :is_displayed, :boolean, default: true, null: false
  end
end

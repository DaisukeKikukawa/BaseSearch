class RemoveImageFromGrounds < ActiveRecord::Migration[7.1]
  def change
    remove_column :grounds, :image, :string
  end
end

class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.references :belongable, polymorphic: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

class CreatePlaylistCategories < ActiveRecord::Migration
  def change
    create_table :playlist_categories do |t|
      t.integer :playlist_id
      t.integer :category_id

      t.belongs_to :playlists
      t.belongs_to :categories

      t.timestamps
    end

    add_index :playlist_categories, :playlist_id
    add_index :playlist_categories, :category_id
  end
end

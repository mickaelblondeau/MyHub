class ClearCategoriesDuplicate < ActiveRecord::Migration
  def change
    remove_column :playlist_categories, :playlists_id
    remove_column :playlist_categories, :categories_id
    remove_column :video_categories, :videos_id
    remove_column :video_categories, :categories_id
  end
end

class ClearCategoriesRelations < ActiveRecord::Migration
  def change
    remove_column :videos, :category_id
    remove_column :playlists, :category_id
  end
end

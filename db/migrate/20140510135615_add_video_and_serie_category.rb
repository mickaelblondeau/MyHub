class AddVideoAndSerieCategory < ActiveRecord::Migration
  def change
    add_column :videos, :category_id, :integer
    add_column :playlists, :category_id, :integer

    add_index :videos, :category_id
    add_index :playlists, :category_id
  end
end

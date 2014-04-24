class RenameSerieIdToPlaylistId < ActiveRecord::Migration
  def change
    add_column :playlist_users, :playlist_id, :integer
    add_index :playlist_users, :playlist_id
    add_index :playlist_users, :user_id

    add_index :channels, :user_id
    add_index :channels, :api_id

    add_index :playlists, :user_id

    add_index :videos, :api_id
    add_index :videos, :channel_id
    add_column :videos, :playlist_id, :integer
    add_index :videos, :playlist_id

    remove_column :playlist_users, :serie_id
    remove_column :videos, :serie_id
  end
end

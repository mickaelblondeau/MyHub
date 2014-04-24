class AddIndexesOnLikes < ActiveRecord::Migration
  def change
    add_index :likes, :user_id
    add_index :likes, :channel_id
    add_index :likes, :video_id
    add_index :likes, :playlist_id
  end
end

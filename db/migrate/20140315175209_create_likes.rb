class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :owner_id
      t.integer :user_id
      t.integer :channel_id
      t.integer :video_id
      t.integer :playlist_id

      t.belongs_to :user
      t.belongs_to :channel
      t.belongs_to :playlist
      t.belongs_to :video

      t.timestamps
    end

    add_index :likes, :owner_id

    add_index :comments, :user_id
    add_index :comments, :channel_id
    add_index :comments, :video_id
    add_index :comments, :playlist_id
  end
end

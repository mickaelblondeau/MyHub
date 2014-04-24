class CreateCooperations < ActiveRecord::Migration
  def change
    create_table :cooperations do |t|
      t.integer :user_id
      t.integer :channel_id

      t.belongs_to :user
      t.belongs_to :channel

      t.timestamps
    end

    add_index :cooperations, :user_id
    add_index :cooperations, :channel_id
    add_index :articles, :channel_id
    add_index :articles, :playlist_id
    add_index :articles, :user_id
    add_index :votes, :video_id
    add_index :votes, :playlist_id
    add_index :votes, :user_id
  end
end

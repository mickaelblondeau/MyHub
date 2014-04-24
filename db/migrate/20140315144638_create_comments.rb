class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :channel_id
      t.integer :video_id
      t.integer :playlist_id
      t.text :content

      t.belongs_to :user
      t.belongs_to :channel
      t.belongs_to :video
      t.belongs_to :playlist

      t.timestamps
    end
  end
end

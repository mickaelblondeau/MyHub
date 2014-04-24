class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.string :ip

      t.integer :user_id
      t.integer :video_id
      t.integer :playlist_id

      t.belongs_to :user
      t.belongs_to :playlist
      t.belongs_to :video

      t.timestamps
    end
  end
end

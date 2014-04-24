class CreatePlaylistUsers < ActiveRecord::Migration
  def change
    create_table :playlist_users do |t|
      t.integer :serie_id
      t.integer :user_id

      t.belongs_to :serie
      t.belongs_to :user

      t.timestamps
    end
  end
end

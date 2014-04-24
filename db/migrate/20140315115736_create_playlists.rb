class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :description
      t.integer :user_id

      t.belongs_to :user

      t.timestamps
    end
  end
end

class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :channel_id
      t.integer :playlist_id

      t.belongs_to :channel
      t.belongs_to :playlist
      t.belongs_to :user

      t.timestamps
    end

    remove_column :votes, :ip
  end
end

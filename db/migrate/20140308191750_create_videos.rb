class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.text :description
      t.string :api_id
      t.integer :channel_id

      t.belongs_to :channel

      t.timestamps
    end
  end
end

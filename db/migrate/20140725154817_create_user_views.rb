class CreateUserViews < ActiveRecord::Migration
  def change
    create_table :user_views do |t|
      t.integer :user_id
      t.integer :video_id
      t.belongs_to :user
      t.belongs_to :video
      t.timestamps
    end
    add_index :user_views, :user_id
    add_index :user_views, :video_id
  end
end

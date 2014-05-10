class CreateVideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.integer :video_id
      t.integer :category_id

      t.belongs_to :videos
      t.belongs_to :categories

      t.timestamps
    end

    add_index :video_categories, :video_id
    add_index :video_categories, :category_id
  end
end

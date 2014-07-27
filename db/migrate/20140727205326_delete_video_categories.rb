class DeleteVideoCategories < ActiveRecord::Migration
  def change
    drop_table :articles
    drop_table :video_categories
  end
end

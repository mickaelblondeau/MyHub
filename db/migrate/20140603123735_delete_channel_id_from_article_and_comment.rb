class DeleteChannelIdFromArticleAndComment < ActiveRecord::Migration
  def change
    remove_column :articles, :channel_id
    add_index :category_links, :parent_id
  end
end

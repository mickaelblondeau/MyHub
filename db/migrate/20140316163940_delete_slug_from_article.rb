class DeleteSlugFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :slug
  end
end

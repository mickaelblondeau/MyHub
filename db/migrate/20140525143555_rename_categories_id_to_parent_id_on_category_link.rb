class RenameCategoriesIdToParentIdOnCategoryLink < ActiveRecord::Migration
  def change
    rename_column :category_links, :categories_id, :parent_id
  end
end

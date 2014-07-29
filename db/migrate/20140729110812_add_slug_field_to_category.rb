class AddSlugFieldToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug_label, :string
  end
end

class CreateCategoryLinks < ActiveRecord::Migration
  def change
    create_table :category_links do |t|
      t.integer :category_id

      t.belongs_to :categories

      t.timestamps
    end

    add_index :category_links, :category_id
  end
end

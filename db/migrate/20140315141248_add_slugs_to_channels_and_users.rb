class AddSlugsToChannelsAndUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug

    add_column :channels, :slug, :string
    add_index :channels, :slug
  end
end

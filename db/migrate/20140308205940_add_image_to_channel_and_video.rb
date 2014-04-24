class AddImageToChannelAndVideo < ActiveRecord::Migration
  def change
    add_column :channels, :image, :string
    add_column :videos, :image, :string
  end
end

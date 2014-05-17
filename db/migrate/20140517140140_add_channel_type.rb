class AddChannelType < ActiveRecord::Migration
  def change
    add_column :channels, :type, :integer
  end
end

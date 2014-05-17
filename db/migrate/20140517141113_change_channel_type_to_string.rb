class ChangeChannelTypeToString < ActiveRecord::Migration
  def change
    remove_column :channels, :type
    add_column :channels, :type, :string
  end
end

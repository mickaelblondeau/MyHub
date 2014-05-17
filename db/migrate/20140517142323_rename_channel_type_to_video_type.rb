class RenameChannelTypeToVideoType < ActiveRecord::Migration
  def change
    rename_column :channels, :type, :video_type
  end
end

class ReworkCooperationPermissions < ActiveRecord::Migration
  def change
    remove_column :cooperation_permissions, :channel_id
    remove_column :cooperation_permissions, :cooperation_id
    add_column :cooperation_permissions, :playlist_id, :integer
    add_index :cooperation_permissions, :playlist_id
  end
end

class DeletePermissionTable < ActiveRecord::Migration
  def change
    drop_table :permissions
    rename_column :cooperation_permissions, :permission_id, :permission
  end
end

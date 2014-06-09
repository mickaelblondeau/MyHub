class MergeCooperationInCooperationPermission < ActiveRecord::Migration
  def change
    drop_table :cooperations

    add_column :cooperation_permissions, :user_id, :integer
    add_column :cooperation_permissions, :channel_id, :integer

    add_index :cooperation_permissions, :user_id
    add_index :cooperation_permissions, :channel_id
  end
end

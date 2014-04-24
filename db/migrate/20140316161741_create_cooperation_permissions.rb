class CreateCooperationPermissions < ActiveRecord::Migration
  def change
    create_table :cooperation_permissions do |t|
      t.integer :permission_id
      t.integer :cooperation_id

      t.belongs_to :permission
      t.belongs_to :cooperation

      t.timestamps
    end

    add_index :cooperation_permissions, :permission_id
    add_index :cooperation_permissions, :cooperation_id
  end
end

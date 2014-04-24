class ChangeOwnerIdToUserIdOnSeries < ActiveRecord::Migration
  def change
    add_column :series, :user_id, :integer
    add_index :series, :user_id

    remove_column :serie_users, :owner
    remove_index :series, :owner_id
  end
end

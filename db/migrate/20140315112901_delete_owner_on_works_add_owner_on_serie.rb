class DeleteOwnerOnWorksAddOwnerOnSerie < ActiveRecord::Migration
  def change
    add_column :series, :owner_id, :integer
    add_index :series, :owner_id

    remove_column :serie_users, :owner
  end
end

class DeleteOwnerIdOnSeries < ActiveRecord::Migration
  def change
    remove_column :series, :owner_id
  end
end

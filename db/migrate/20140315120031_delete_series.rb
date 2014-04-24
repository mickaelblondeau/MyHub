class DeleteSeries < ActiveRecord::Migration
  def change
    drop_table :series
    drop_table :serie_users
  end
end

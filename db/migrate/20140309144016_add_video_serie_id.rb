class AddVideoSerieId < ActiveRecord::Migration
  def change
    add_column :videos, :serie_id, :integer
    add_index :videos, :serie_id
  end
end

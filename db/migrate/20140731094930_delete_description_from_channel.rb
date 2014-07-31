class DeleteDescriptionFromChannel < ActiveRecord::Migration
  def change
    remove_column :channels, :description
  end
end

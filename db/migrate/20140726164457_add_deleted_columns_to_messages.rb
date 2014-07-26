class AddDeletedColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :owner_deleted, :boolean
    add_column :messages, :user_deleted, :boolean
  end
end

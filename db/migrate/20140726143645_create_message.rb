class CreateMessage < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :owner_id
      t.integer :user_id
      t.text :message
      t.belongs_to :user
      t.timestamps
    end
    add_index :messages, :owner_id
    add_index :messages, :user_id
  end
end

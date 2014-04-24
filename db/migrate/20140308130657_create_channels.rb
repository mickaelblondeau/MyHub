class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description
      t.string :api_id
      t.boolean :validated
      t.string :validation_key
      t.integer :user_id

      t.belongs_to :user

      t.timestamps
    end
  end
end

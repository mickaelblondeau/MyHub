class CreateSerieUsers < ActiveRecord::Migration
  def change
    create_table :serie_users do |t|
      t.boolean :owner
      t.integer :serie_id
      t.integer :user_id

      t.belongs_to :serie
      t.belongs_to :user

      t.timestamps
    end
  end
end

class DropPunches < ActiveRecord::Migration
  def change
    drop_table :punches
  end
end

class AddWeekFieldInVote < ActiveRecord::Migration
  def change
    add_column :votes, :weekly, :boolean
  end
end

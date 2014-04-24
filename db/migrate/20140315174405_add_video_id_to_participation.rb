class AddVideoIdToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :video_id, :integer
    add_index :participations, :video_id
  end
end

class RemoveVideoIdFromLike < ActiveRecord::Migration
  def change
    remove_column :votes, :video_id
  end
end

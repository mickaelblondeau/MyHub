class ReaddVotesForVideoAndDeleteLike < ActiveRecord::Migration
  def change
    remove_column :likes, :video_id
    add_column :votes, :video_id, :integer
    add_index :votes, :video_id
  end
end

class RemoveChannelCommentVoteLike < ActiveRecord::Migration
  def change
    remove_column :votes, :channel_id
    remove_column :likes, :channel_id
    remove_column :comments, :channel_id
  end
end

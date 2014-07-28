module ApplicationHelper
  def get_featured_series
    Playlist.last(3)
  end

  def get_new_videos(user_id)
    Like.get_unseen_count(user_id)
  end

  def get_new_messages(user_id)
    Message.where('user_id = ? AND user_deleted IS NOT ? AND seen IS NOT ?', current_user.id, true, true).length
  end
end

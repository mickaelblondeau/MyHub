module ApplicationHelper
  def get_featured_series
    Playlist.last(3)
  end

  def get_new_videos(user_id)
    Like.get_unseen_count(user_id)
  end
end

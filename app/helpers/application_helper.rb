module ApplicationHelper
  def get_featured_series
    series = Playlist.last(3)
  end
end

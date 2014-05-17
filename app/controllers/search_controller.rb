class SearchController < ApplicationController
  def index
    @search = get_params[:q]
    @series = Playlist.where('title LIKE ? OR description LIKE ?', "%#{@search}%", "%#{@search}%")
  end

  def get_params
    params.permit(:q)
  end
end

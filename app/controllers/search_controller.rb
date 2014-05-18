class SearchController < ApplicationController
  def index
    @search = params[:q]
    if @search.length > 3
      @series = Playlist.where('title LIKE ? OR description LIKE ?', "%#{@search}%", "%#{@search}%")
    else
      @series = []
    end
  end
end

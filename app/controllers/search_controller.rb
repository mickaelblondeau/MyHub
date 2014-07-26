class SearchController < ApplicationController
  def index
    search = params[:q]
    if search.length > 3
      search = '%' + search + '%'
      @series = Playlist.where('title LIKE ? OR description LIKE ?', search, search)
      @videos = Video.where('name LIKE ? OR description LIKE ?', search, search)
    else
      flash[:alert] = t('errors.messages.search_too_short', :count => 4)
      @series = @videos = []
    end
  end

  def new
    redirect_to '/search/' + params[:search].to_s
  end
end

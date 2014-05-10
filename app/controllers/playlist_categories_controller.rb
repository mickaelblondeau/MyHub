class PlaylistCategoriesController < ApplicationController

  def create
    @playlist_category = PlaylistCategory.new(get_params)
    authorize! :create, @playlist_category
    if @playlist_category.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to playlist_path(@playlist_category.playlist)
  end

  def destroy
    @playlist_category = PlaylistCategory.find(params[:id])
    authorize! :destroy, @playlist_category
    path = @playlist_category.playlist
    @playlist_category.delete
    flash[:notice] = 'Ok'
    redirect_to playlist_path(path)
  end

  def get_params
    params[:playlist_category].permit(:playlist_id, :category_id)
  end

end

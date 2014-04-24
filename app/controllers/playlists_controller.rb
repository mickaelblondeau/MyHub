class PlaylistsController < ApplicationController
  def index
    authorize! :index, Playlist
    @playlists = Playlist.where('user_id = ?', current_user.id)
    @new_playlist = Playlist.new
  end

  def show
    @playlist = Playlist.find(params[:id])
    @new_participation = Participation.new
    @comments = Comment.where('playlist_id = ?', @playlist.id)
  end

  def create
    authorize! :create, Playlist
    @playlist = Playlist.new(get_params)
    @playlist.user_id = current_user.id
    if @playlist.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to playlists_path
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    authorize! :manage, @playlist
    @playlist.delete
    flash[:notice] = 'Ok'
    redirect_to playlists_path
  end

  def get_params
    params[:playlist].permit(:title, :description)
  end
end

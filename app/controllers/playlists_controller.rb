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
    @like = Like.where('playlist_id = ?', @playlist.id).first
    @votes = Vote.where('playlist_id = ?', @playlist.id)
    @vote = Vote.where('playlist_id = ? AND user_id = ?', @playlist.id, current_user.id).first
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    authorize! :manage, @playlist
    if @playlist.update(get_params)
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to playlists_path
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
    @playlist.destroy
    flash[:notice] = 'Ok'
    redirect_to playlists_path
  end

  def get_params
    params[:playlist].permit(:title, :description, :icon)
  end
end

class SubscriptionController < ApplicationController
  def index
  	authorize! :index, Channel
    @likes = Like.where('owner_id = ?', current_user.id).includes(:user_videos, :playlist_videos)
    @likes = Like.sort_likes(@likes, current_user.id)
  end

  def show
    authorize! :show, Channel
    if params[:type] == 'u'
      user = User.friendly.find(params[:slug])
      @like = Like.where('owner_id = ? AND user_id = ?', current_user.id, user.id).first
    elsif params[:type] == 's'
      playlist = Playlist.friendly.find(params[:slug])
      @like = Like.where('owner_id = ? AND playlist_id = ?', current_user.id, playlist.id).first
    end
    if @like == nil
      redirect_to subscription_index_path
    end
  end
end
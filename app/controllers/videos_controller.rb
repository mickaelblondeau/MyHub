class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    @comments = Comment.where('video_id = ?', @video.id)
  end

  def create
    @video = Video.new(get_params)
    authorize! :manage, @video
    if @video.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @video.channel
  end

  def destroy
    @video = Video.find(params[:id])
    authorize! :manage, @video
    channel = @video.channel
    @video.delete
    flash[:notice] = 'Ok'
    redirect_to channel
  end

  def get_params
    params[:video].permit(:api_id, :channel_id, :playlist_id)
  end
end

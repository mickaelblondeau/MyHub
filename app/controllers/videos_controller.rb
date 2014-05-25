class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    impressionist(@video)
    @comments = Comment.where('video_id = ?', @video.id)
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    authorize! :manage, @video
    if @video.update(params[:video].permit(:playlist_id, :name, :description))
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @video.channel
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
    @video.destroy
    flash[:notice] = 'Ok'
    redirect_to channel
  end

  def get_params
    params[:video].permit(:api_id, :channel_id, :playlist_id)
  end
end

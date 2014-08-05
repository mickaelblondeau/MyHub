class VideosController < ApplicationController
  def show
    @video = Video.find(Encoder::decode_id(params[:id]))
    impressionist(@video, nil, :unique => [:session_hash])
    if current_user
      user_view = UserView.new
      user_view.user = current_user
      user_view.video = @video
      user_view.save
    end
    @comments = Comment.where('video_id = ?', @video.id)
  end

  def edit
    @video = Video.find(Encoder::decode_id(params[:id]))
    authorize! :edit, @video
  end

  def update
    @video = Video.find(Encoder::decode_id(params[:id]))
    @video.playlist_id = params[:video][:playlist_id]
    @video.name = params[:video][:name]
    @video.description = params[:video][:description]
    authorize! :manage, @video
    if @video.save
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
    @video = Video.find(Encoder::decode_id(params[:id]))
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

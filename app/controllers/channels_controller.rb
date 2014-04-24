class ChannelsController < ApplicationController
  def index
    authorize! :index, Channel
    @channels = Channel.where(:user_id => current_user.id)
    @new_channel = Channel.new
  end

  def show
    @channel = Channel.friendly.find(params[:id])
    @videos = Video.where(:channel_id => @channel.id)
    @new_video = Video.new
    @comments = Comment.where('channel_id = ?', @channel.id)
  end

  def update
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    if @channel.ownerValidated
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @channel
  end

  def create
    authorize! :create, Channel
    @channel = Channel.new(get_params)
    @channel.user_id = current_user.id
    if @channel.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to channels_path
  end

  def destroy
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    @channel.delete
    flash[:notice] = 'Ok'
    redirect_to channels_path
  end

  def get_params
    params[:channel].permit(:api_id, :playlist)
  end
end

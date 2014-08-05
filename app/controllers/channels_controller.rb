class ChannelsController < ApplicationController
  def index
    authorize! :index, Channel
    @channels = Channel.where(:user_id => current_user.id)
  end

  def show
    @channel = Channel.friendly.find(params[:id])
    if !@channel.validated? and @channel.find_existing
      flash[:alert] = 'Ko'
      redirect_to channels_path
    end
    authorize! :manage, @channel
  end

  def update
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    if @channel.owner_validated
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
    if @channel.save_with_slug
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to channels_path
  end

  def destroy
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    @channel.destroy
    flash[:notice] = 'Ok'
    redirect_to channels_path
  end

  def get_params
    params[:channel].permit(:api_id, :playlist, :video_type)
  end
end

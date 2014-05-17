class CooperationsController < ApplicationController

  def show
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    @cooperations = Cooperation.where('channel_id = ?', @channel.id)
    @new_cooperation = Cooperation.new
  end

  def create
    @cooperation = Cooperation.new(get_params)
    authorize! :create, @cooperation
    if @cooperation.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to cooperation_path(@cooperation.channel)
  end

  def destroy
    @cooperation = Cooperation.find(params[:id])
    authorize! :destroy, @cooperation
    path = @cooperation.channel
    @cooperation.destroy
    flash[:notice] = 'Ok'
    redirect_to cooperation_path(path)
  end

  def get_params
    params[:cooperation].permit(:user_id, :channel_id)
  end

end

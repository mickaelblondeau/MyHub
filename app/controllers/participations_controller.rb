class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(get_params)
    authorize! :manage, @participation
    if @participation.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to edit_playlist_path(@participation.playlist)
  end

  def destroy
    @participation = Participation.find(params[:id])
    authorize! :manage, @participation
    @participation.destroy
    flash[:notice] = 'Ok'
    redirect_to edit_playlist_path(@participation.playlist)
  end

  def get_params
    params[:participation].permit(:user_id, :playlist_id, :comment)
  end
end
class ParticipationsController < ApplicationController
  def create
    @participation = Participation.new(get_params)
    authorize! :manage, @participation
    user = User.find_by_user_name(get_params[:user_id])
    if user
      @participation.user_id = user.id
      if @participation.save
        flash[:notice] = 'Ok'
      else
        flash[:alert] = 'Ko'
      end
    else
      flash[:alert] = 'Ko - wrong user'
    end
    redirect_to redirect
  end

  def destroy
    @participation = Participation.find(params[:id])
    authorize! :manage, @participation
    @participation.destroy
    flash[:notice] = 'Ok'
    redirect_to redirect
  end

  def get_params
    params[:participation].permit(:user_id, :playlist_id, :video_id, :comment)
  end

  def redirect
    if @participation.playlist
      edit_playlist_path(@participation.playlist)
    else
      edit_video_path(@participation.video)
    end
  end
end
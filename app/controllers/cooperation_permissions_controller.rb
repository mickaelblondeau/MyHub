class CooperationPermissionsController < ApplicationController

  def create
    @cooperation_permission = CooperationPermission.new(get_params)
    authorize! :create, @cooperation_permission
    user = User.find_by_user_name(get_params[:user_id])
    if user
      @cooperation_permission.user_id = user.id
      if @cooperation_permission.save
        flash[:notice] = 'Ok'
      else
        flash[:alert] = 'Ko'
      end
    else
      flash[:alert] = 'Ko - wrong user'
    end
    redirect_to edit_playlist_path(@cooperation_permission.playlist)
  end

  def destroy
    @cooperation_permission = CooperationPermission.find(params[:id])
    authorize! :destroy, @cooperation_permission
    @cooperation_permission.destroy
    flash[:notice] = 'Ok'
    redirect_to edit_playlist_path(@cooperation_permission.playlist)
  end

  def get_params
    params[:cooperation_permission].permit(:user_id, :playlist_id, :permission)
  end

end

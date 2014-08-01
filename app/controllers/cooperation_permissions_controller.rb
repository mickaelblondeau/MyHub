class CooperationPermissionsController < ApplicationController

  def show
    @playlist = Playlist.friendly.find(params[:id])
    authorize! :manage, @playlist
    @new_cooperation_permission = CooperationPermission.new
    @cooperation_permissions = CooperationPermission.where('playlist_id = ?', @playlist.id)
  end

  def create
    @cooperation_permission = CooperationPermission.new(get_params)
    authorize! :create, @cooperation_permission
    if @cooperation_permission.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to playlist_path(@cooperation_permission.playlist)
  end

  def destroy
    @cooperation_permission = CooperationPermission.find(params[:id])
    authorize! :destroy, @cooperation_permission
    @cooperation_permission.destroy
    flash[:notice] = 'Ok'
    redirect_to playlist_path(@cooperation_permission.playlist)
  end

  def get_params
    params[:cooperation_permission].permit(:user_id, :playlist_id, :permission_id)
  end

end

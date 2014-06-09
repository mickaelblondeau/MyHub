class CooperationPermissionsController < ApplicationController

  def show
    @channel = Channel.friendly.find(params[:id])
    authorize! :manage, @channel
    @new_cooperation_permission = CooperationPermission.new
    @cooperation_permissions = CooperationPermission.where('channel_id = ?', @channel.id)
  end

  def create
    @cooperation_permission = CooperationPermission.new(get_params)
    authorize! :create, @cooperation_permission
    if @cooperation_permission.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to cooperation_permission_path(@cooperation_permission.channel_id)
  end

  def destroy
    @cooperation_permission = CooperationPermission.find(params[:id])
    authorize! :destroy, @cooperation_permission
    channel_id = @cooperation_permission.channel_id
    @cooperation_permission.destroy
    flash[:notice] = 'Ok'
    redirect_to cooperation_permission_path(channel_id)
  end

  def get_params
    params[:cooperation_permission].permit(:user_id, :channel_id, :permission_id)
  end

end

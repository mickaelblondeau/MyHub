class CooperationPermissionsController < ApplicationController

  def show
    @cooperation = Cooperation.find(params[:id])
    authorize! :manage, @cooperation
    @new_cooperation_permission = CooperationPermission.new
    @cooperation_permissions = CooperationPermission.where('cooperation_id = ?', @cooperation.id)
  end

  def create
    @cooperation_permission = CooperationPermission.new(get_params)
    authorize! :create, @cooperation_permission
    if @cooperation_permission.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to cooperation_permission_path(@cooperation_permission.cooperation)
  end

  def destroy
    @cooperation_permission = CooperationPermission.find(params[:id])
    authorize! :destroy, @cooperation_permission
    path = @cooperation_permission.cooperation
    @cooperation_permission.delete
    flash[:notice] = 'Ok'
    redirect_to cooperation_permission_path(path)
  end

  def get_params
    params[:cooperation_permission].permit(:permission_id, :cooperation_id)
  end

end

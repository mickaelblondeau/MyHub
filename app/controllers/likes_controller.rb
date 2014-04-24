class LikesController < ApplicationController
  def create
    authorize! :create, Like
    @like = Like.new(get_params)
    @like.owner_id = current_user.id
    if @like.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @like.get_type
  end

  def destroy
    @like = Like.find(params[:id])
    authorize! :destroy, @like
    path = @like.get_type
    @like.delete
    flash[:notice] = 'Ok'
    redirect_to path
  end

  def get_params
    params[:like].permit(:channel_id, :video_id, :playlist_id, :user_id)
  end
end

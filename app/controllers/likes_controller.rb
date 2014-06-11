class LikesController < ApplicationController
  def create
    authorize! :create, Like
    @like = Like.new(get_params)
    @like.owner_id = current_user.id
    if @like.save
      render partial: 'shared/likes', locals: @like.get_params
    else
      render json: {error: :ko}, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize! :destroy, @like
    @like.destroy
    render partial: 'shared/likes', locals: @like.get_delete_params
  end

  def get_params
    params[:like].permit(:playlist_id, :user_id)
  end
end

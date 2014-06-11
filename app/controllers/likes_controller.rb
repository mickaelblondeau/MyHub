class LikesController < ApplicationController
  def create
    authorize! :create, Like
    @like = Like.new(get_params)
    @like.owner_id = current_user.id
    if @like.save
      render_html
    else
      render json: {error: :ko}, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize! :destroy, @like
    @like.destroy
    render_html
  end

  def get_params
    params[:like].permit(:playlist_id, :user_id)
  end

  def render_html
    if @like.user_id
      param_name = :user_id
      object = @like.user
      @like = Like.where('user_id = ?', object.id).first
    else
      param_name = :playlist_id
      object = @like.playlist
      @like = Like.where('playlist_id = ?', object.id).first
    end
    render partial: 'shared/likes', locals: { param_name: param_name, object: object }
  end
end

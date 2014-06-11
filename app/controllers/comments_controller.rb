class CommentsController < ApplicationController
  def create
    authorize! :create, Comment
    @comment = Comment.new(get_params)
    @comment.user_id = current_user.id
    if @comment.save
      render partial: 'shared/comments', locals: @comment.get_params
    else
      render json: {error: :ko}, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    render partial: 'shared/comments', locals: @comment.get_params
  end

  def get_params
    params[:comment].permit(:content, :video_id, :playlist_id)
  end
end

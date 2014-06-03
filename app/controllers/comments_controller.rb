class CommentsController < ApplicationController
  def create
    authorize! :create, Comment
    @comment = Comment.new(get_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @comment.get_type
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    path = @comment.get_type
    @comment.destroy
    flash[:notice] = 'Ok'
    redirect_to path
  end

  def get_params
    params[:comment].permit(:content, :video_id, :playlist_id)
  end
end

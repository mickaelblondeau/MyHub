class CommentsController < ApplicationController
  def create
    authorize! :create, Comment
    @comment = Comment.new(get_params)
    @comment.user_id = current_user.id
    if @comment.save
      render partial: 'shared/comment_post', locals: { comment: @comment }
    else
      render json: {error: :ko}, status: :unprocessable_entity
    end
  end

  def show
    if params[:type] == 'v'
      object = Video.find(params[:id])
    elsif params[:type] == 's'
      object = Playlist.friendly.find(params[:id])
    end
    if params[:page]
      page = params[:page].to_i
    else
      page = 2
    end
    render partial: 'shared/comments_posts', locals: Comment::get_params(object, page)
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    render json: {}
  end

  def get_params
    params[:comment].permit(:content, :video_id, :playlist_id)
  end
end
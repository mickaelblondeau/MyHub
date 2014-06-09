class ArticlesController < ApplicationController
  def create
    @article = Article.new(get_params)
    authorize! :create, @article
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @article.playlist
  end

  def destroy
    @article = Article.find(params[:id])
    authorize! :destroy, @article
    path = @article.playlist
    @article.destroy
    flash[:notice] = 'Ok'
    redirect_to path
  end

  def get_params
    params[:article].permit(:title, :content, :playlist_id)
  end
end

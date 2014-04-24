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
    redirect_to @article.get_type
  end

  def destroy
    @article = Article.find(params[:id])
    authorize! :destroy, @article
    path = @article.get_type
    @article.delete
    flash[:notice] = 'Ok'
    redirect_to path
  end

  def get_params
    params[:article].permit(:title, :content, :channel_id, :playlist_id)
  end
end

class VideoCategoriesController < ApplicationController

  def create
    @video_category = VideoCategory.new(get_params)
    authorize! :create, @video_category
    if @video_category.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to video_path(@video_category.video)
  end

  def destroy
    @video_category = VideoCategory.find(params[:id])
    authorize! :destroy, @video_category
    path = @video_category.video
    @video_category.destroy
    flash[:notice] = 'Ok'
    redirect_to video_path(path)
  end

  def get_params
    params[:video_category].permit(:video_id, :category_id)
  end

end

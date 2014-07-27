class CategoriesController < ApplicationController
  def index
    redirect_to root_path, :status => :moved_permanently
  end

  def new
    authorize! :manage, Category
  end

  def show
    @category = Category.friendly.find(params[:id])
  end

  def edit
    authorize! :manage, Category
    @category = Category.friendly.find(params[:id])
  end

  def update
    authorize! :manage, Category
    @category = Category.friendly.find(params[:id])
    if @category.update(get_params)
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to category_path(@category)
  end

  def create
    authorize! :manage, Category
    @category = Category.new(get_params)
    if @category.save_with_slug
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to category_path(@category)
  end

  def destroy
    authorize! :manage, Category
    @category = Category.friendly.find(params[:id])
    @category.destroy
    flash[:notice] = 'Ok'
    redirect_to categories_path
  end

  def get_params
    params[:category].permit(:label, :icon)
  end
end

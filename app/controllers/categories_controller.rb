class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(get_params)
    authorize! :create, @category
    if @category.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, @category
    @category.destroy
    flash[:notice] = 'Ok'
    redirect_to categories_path
  end

  def get_params
    params[:category].permit(:label, :icon)
  end
end

class CategoryLinksController < ApplicationController
  def create
    authorize! :create, CategoryLink
    @category_link = CategoryLink.new(get_params)
    if @category_link.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to request.referer
  end

  def destroy
    @category_link = CategoryLink.find(params[:id])
    authorize! :destroy, @category_link
    @category_link.destroy
    flash[:notice] = 'Ok'
    redirect_to request.referer
  end

  def get_params
    params[:category_link].permit(:category_id, :parent_id)
  end
end

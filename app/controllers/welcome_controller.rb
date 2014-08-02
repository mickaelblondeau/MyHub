class WelcomeController < ApplicationController
  def index
    categories = Category::sort_categories()
    @categories = categories.paginate(:page => params[:page], :per_page => 10)
  end
end
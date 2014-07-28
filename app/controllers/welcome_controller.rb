class WelcomeController < ApplicationController
  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 10)
  end
end
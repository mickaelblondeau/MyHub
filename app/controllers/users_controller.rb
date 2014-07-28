class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @videos = @user.videos.paginate(:page => params[:page], :per_page => 10)
  end
end

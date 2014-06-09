class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @like = Like.where('user_id = ?', @user.id).first
  end
end

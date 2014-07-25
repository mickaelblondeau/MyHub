class SubscriptionController < ApplicationController
  def index
  	authorize! :index, Channel
    @likes = Like.where('owner_id = ?', current_user.id)
  end

  def show
    authorize! :index, Channel
    @like = Like.find(params[:id])
  end
end

class SubscriptionController < ApplicationController
  def index
  	authorize! :index, Channel
    @likes = Like.where('owner_id = ?', current_user.id)
  end
end

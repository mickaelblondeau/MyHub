class SubscriptionController < ApplicationController
  def index
  	authorize! :index, Channel
  end
end

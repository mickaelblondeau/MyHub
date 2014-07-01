class WelcomeController < ApplicationController
  def index
    @categories = Category.all
    if current_user
      @likes = Like.where('owner_id = ?', current_user.id)
    end
  end
end

class VotesController < ApplicationController
  def create
    authorize! :create, Vote
    @vote = Vote.new(get_params)
    @vote.user_id = current_user.id
    if @vote.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to @vote.get_type
  end

  def destroy
    @vote = Vote.find(params[:id])
    authorize! :destroy, @vote
    path = @vote.get_type
    @vote.destroy
    flash[:notice] = 'Ok'
    redirect_to path
  end

  def get_params
    params[:vote].permit(:video_id, :playlist_id, :vote)
  end
end

class VotesController < ApplicationController
  def create
    authorize! :create, Vote
    @vote = Vote.new(get_params)
    @vote.user_id = current_user.id
    @vote.weekly = true
    existing_vote = @vote.vote_exist
    if existing_vote
      existing_vote.vote = @vote.vote
      existing_vote.save
      render partial: 'shared/votes', locals: existing_vote.get_params
    else
      if @vote.save
        render partial: 'shared/votes', locals: @vote.get_params
      else
        render json: {error: :ko}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    authorize! :destroy, @vote
    @vote.destroy
    render partial: 'shared/votes', locals: @vote.get_delete_params
  end

  def get_params
    params[:vote].permit(:video_id, :playlist_id, :vote)
  end
end

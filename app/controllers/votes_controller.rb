class VotesController < ApplicationController
  def create
    authorize! :create, Vote
    @vote = Vote.new(get_params)
    @vote.user_id = current_user.id
    @vote.weekly = true
    if existing_vote = @vote.vote_exist
      existing_vote.vote = @vote.vote
      existing_vote.save
      render_html existing_vote
    else
      if @vote.save
        render_html @vote
      else
        render json: {error: :ko}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    authorize! :destroy, @vote
    @vote.destroy
    render_html @vote
  end

  def get_params
    params[:vote].permit(:video_id, :playlist_id, :vote)
  end

  def render_html(vote)
    if vote.video_id
      param_name = :video_id
      object = vote.video
      @votes = Vote.where('video_id = ?', object.id)
      if current_user
        vote = Vote.where('video_id = ? AND user_id = ?', object.id, current_user.id).first
      end
    else
      param_name = :playlist_id
      object = vote.playlist
      @votes = Vote.where('playlist_id = ?', object.id)
      if current_user
        vote = Vote.where('playlist_id = ? AND user_id = ?', object.id, current_user.id).first
      end
    end
    render partial: 'shared/votes', locals: { param_name: param_name, object: object }
  end
end

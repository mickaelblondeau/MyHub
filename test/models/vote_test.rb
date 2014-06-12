require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def createVote
    vote = Vote.new
    vote.user_id = 1
    vote.video_id = 1
    vote.weekly = true
    vote
  end

  test 'should not save without playlist or video' do
    vote = Vote.new
    vote.user_id = 1
    assert_not vote.save
  end

  test 'should save with playlist or video' do
    vote = Vote.new
    vote.user_id = 1
    vote.playlist_id = 1
    assert vote.save

    vote = Vote.new
    vote.user_id = 1
    vote.video_id = 1
    assert vote.save
  end

  test 'should not save duplicate' do
    assert createVote.save
    assert_not createVote.save
  end

  test 'get type' do
    assert votes(:video_vote).get_type == videos(:one)
    assert votes(:playlist_vote).get_type == playlists(:one)
  end

  test 'self get params' do
    params = Vote::get_params(videos(:one), users(:one))
    assert params[:param_name] == :video_id
    assert params[:id] == videos(:one).id

    params = Vote::get_params(playlists(:one), users(:one))
    assert params[:param_name] == :playlist_id
    assert params[:id] == playlists(:one).id
  end

  test 'get params' do
    vote = createVote
    params = vote.get_params
    assert params[:param_name] == :video_id
    assert params[:id] == videos(:one).id
  end

  test 'get delete params' do
    vote = createVote
    params = vote.get_delete_params
    assert params[:param_name] == :video_id
    assert params[:id] == videos(:one).id
  end
end

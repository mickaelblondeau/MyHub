require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def createVote
    vote = Vote.new
    vote.user_id = 1
    vote.video_id = 1
    vote.weekly = true
    return vote.save
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
    assert createVote
    assert_not createVote
  end

  test 'get type' do
    assert votes(:video_vote).get_type == videos(:one)
    assert votes(:playlist_vote).get_type == playlists(:one)
  end
end

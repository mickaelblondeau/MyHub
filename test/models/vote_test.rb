require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'get type' do
	assert votes(:video_vote).get_type == videos(:one)
	assert votes(:playlist_vote).get_type == playlists(:one)
  end
end

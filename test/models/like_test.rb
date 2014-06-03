require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'get type' do
	assert likes(:user_like).get_type == users(:one)
	assert likes(:playlist_like).get_type == playlists(:one)
  end
end

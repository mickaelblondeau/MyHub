require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test 'get type' do
    assert likes(:user_like).get_type == users(:one)
    assert likes(:playlist_like).get_type == playlists(:one)
  end

  test 'get type name' do
    assert likes(:user_like).get_type_name == users(:one).user_name
    assert likes(:playlist_like).get_type_name == playlists(:one).title
  end
end

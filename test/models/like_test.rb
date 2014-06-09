require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def createLike
    like = Like.new
    like.owner_id = 2
    like.playlist_id = 1
    return like.save
  end

  test 'should not save without user or playlist' do
    like = Like.new
    like.owner_id = 2
    assert_not like.save
  end

  test 'should save with user or playlist' do
    like = Like.new
    like.owner_id = 2
    like.user_id = 1
    assert like.save

    like = Like.new
    like.owner_id = 2
    like.playlist_id = 1
    assert like.save
  end

  test 'should not save duplicate' do
    assert createLike
    assert_not createLike
  end

  test 'get type' do
    assert likes(:user_like).get_type == users(:one)
    assert likes(:playlist_like).get_type == playlists(:one)
  end

  test 'get type name' do
    assert likes(:user_like).get_type_name == users(:one).user_name
    assert likes(:playlist_like).get_type_name == playlists(:one).title
  end
end

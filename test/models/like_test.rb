require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def createLike
    like = Like.new
    like.owner_id = 2
    like.playlist_id = 1
    like
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
    assert createLike.save
    assert_not createLike.save
  end

  test 'get type' do
    assert likes(:user_like).get_type == users(:one)
    assert likes(:playlist_like).get_type == playlists(:one)
  end

  test 'get type name' do
    assert likes(:user_like).get_type_name == users(:one).user_name
    assert likes(:playlist_like).get_type_name == playlists(:one).title
  end

  test 'self get params' do
    params = Like::get_params(users(:one), users(:one))
    assert params[:param_name] == :user_id
    assert params[:id] == users(:one).id
    assert params[:like] == likes(:user_like)

    params = Like::get_params(playlists(:one), users(:one))
    assert params[:param_name] == :playlist_id
    assert params[:id] == playlists(:one).id
    assert params[:like] == likes(:playlist_like)
  end

  test 'get params' do
    like = createLike
    params = like.get_params
    assert params[:param_name] == :playlist_id
    assert params[:id] == playlists(:one).id
    assert params[:like] == like
  end

  test 'get delete params' do
    like = createLike
    params = like.get_delete_params
    assert params[:param_name] == :playlist_id
    assert params[:id] == playlists(:one).id
    assert params[:like] == nil
  end
end

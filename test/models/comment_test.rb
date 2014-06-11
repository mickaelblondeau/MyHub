require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not create without content' do
    comment = Comment.new
    comment.video_id = 1
    assert_not comment.save
  end

  test 'should not create without video or playlist' do
    comment = Comment.new
    comment.content = 'comment'
    assert_not comment.save
  end

  test 'should create with comment and video or playlist' do
    comment = Comment.new
    comment.video_id = 1
    comment.content = 'comment'
    assert comment.save

    comment = Comment.new
    comment.playlist_id = 1
    comment.content = 'comment'
    assert comment.save
  end

  test 'get type' do
    assert comments(:video_comment).get_type == videos(:one)
    assert comments(:playlist_comment).get_type == playlists(:one)
  end

  test 'get type owner' do
    assert comments(:video_comment).get_type_owner == videos(:one).channel.user
    assert comments(:playlist_comment).get_type_owner == playlists(:one).user
  end

  test 'self get params' do
    params = Comment::get_params(videos(:one))
    assert params[:param_name] == :video_id
    assert params[:id] == videos(:one).id

    params = Comment::get_params(playlists(:one))
    assert params[:param_name] == :playlist_id
    assert params[:id] == playlists(:one).id
  end

  test 'get params' do
    comment = Comment.new
    comment.content = 'comment'
    comment.video_id = 1
    comment.save
    params = comment.get_params
    assert params[:param_name] == :video_id
    assert params[:id] == videos(:one).id
  end
end

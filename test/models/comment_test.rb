require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'should not create without content' do
    comment = Comment.new
    assert_not comment.save
  end

  test 'should create with content' do
    comment = Comment.new
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
end

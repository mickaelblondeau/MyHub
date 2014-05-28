require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  VALID_VIDEO_ID = 'wCzcQbqVEyg'
  INVALID_KEY = 'invalid key&?_'

  def create_correct_video
    video = Video.new
    video.channel_id = channels(:one).id
    video.playlist_id = playlists(:one).id
    video.api_id = VALID_VIDEO_ID
    video
  end

  test 'should not save without api_id' do
    video = Video.new
    video.channel_id = channels(:one).id
    video.playlist_id = playlists(:one).id
    assert_not video.save
  end

  test 'should not save with wrong api_id' do
    video = Video.new
    video.channel_id = channels(:one).id
    video.playlist_id = playlists(:one).id
    video.api_id = INVALID_KEY
    assert_not video.save
  end

  test 'should not save without channel_id' do
    video = Video.new
    video.playlist_id = channels(:one).id
    video.api_id = VALID_VIDEO_ID
    assert_not video.save
  end

  test 'should not save with wrong channel_id' do
    video = Video.new
    video.channel_id = 0
    video.playlist_id = playlists(:one).id
    video.api_id = VALID_VIDEO_ID
    assert_not video.save
  end

  test 'should not save without playlist_id' do
    video = Video.new
    video.channel_id = channels(:one).id
    video.api_id = VALID_VIDEO_ID
    assert_not video.save
  end

  test 'should save correct video' do
    video = create_correct_video
    assert video.save
  end

  test 'should not save existing video' do
    video = create_correct_video
    video.save
    video = create_correct_video
    assert_not video.save
  end
end

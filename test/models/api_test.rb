require 'test_helper'

class ApiTest < ActiveSupport::TestCase
  INVALID_KEY = 'invalid key&?_'
  VALID_YT_CHANNEL = 'UC_x5XG1OV2P6uZZ5FSM9Ttw'
  VALID_DM_CHANNEL = 'rs'
  VALID_VI_CHANNEL = 'brad'
  VALID_YT_VIDEO = 'ga2Z03eIlCY'
  VALID_DM_VIDEO = 'x7lni3'
  VALID_VI_VIDEO = '50873112'

  def check_channel_data(channel)
    assert channel
    assert channel[:name]
    assert channel[:description]
    assert channel[:image]
    assert channel[:api_id]
  end

  test 'invalid youtube channel' do
    assert_not Api::channel_info(INVALID_KEY, 'yt')
  end

  test 'valid youtube channel' do
    data = Api::channel_info(VALID_YT_CHANNEL, 'yt')
    check_channel_data(data)
  end

  test 'invalid dailymotion channel' do
    assert_not Api::channel_info(INVALID_KEY, 'dm')
  end

  test 'valid dailymotion channel' do
    data = Api::channel_info(VALID_DM_CHANNEL, 'dm')
    check_channel_data(data)
  end

  test 'invalid vimeo channel' do
    assert_not Api::channel_info(INVALID_KEY, 'vi')
  end

  test 'valid vimeo channel' do
    data = Api::channel_info(VALID_VI_CHANNEL, 'vi')
    check_channel_data(data)
  end

  def check_video_data(video)
    assert video
    assert video[:name]
    assert video[:description]
    assert video[:image]
    assert video[:created_at]
    assert video[:channel]
  end

  test 'invalid youtube video' do
    assert_not Api::video_info(INVALID_KEY, 'yt')
  end

  test 'valid youtube video' do
    data = Api::video_info(VALID_YT_VIDEO, 'yt')
    check_video_data(data)
  end

  test 'invalid dailymotion video' do
    assert_not Api::video_info(INVALID_KEY, 'dm')
  end

  test 'valid dailymotion video' do
    data = Api::video_info(VALID_DM_VIDEO, 'dm')
    check_video_data(data)
  end

  test 'invalid vimeo video' do
    assert_not Api::video_info(INVALID_KEY, 'vi')
  end

  test 'valid vimeo video' do
    data = Api::video_info(VALID_VI_VIDEO, 'vi')
    check_video_data(data)
  end
end
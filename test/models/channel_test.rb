require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  VALID_CHANNEL_ID = 'UCsuG8qXz0GTnwc-jr3kwS8g'
  VALID_VALIDATION_KEY = 'xgsApS4Avd2516I'
  VALID_VIDEO_TYPE = 'yt'
  INVALID_KEY = 'invalid key&?_'

  def create_correct_channel
    channel = Channel.new
    channel.api_id = VALID_CHANNEL_ID
    channel.video_type = VALID_VIDEO_TYPE
    channel
  end

  test 'should not save without api_id' do
    channel = Channel.new
    channel.video_type = VALID_VIDEO_TYPE
    assert_not channel.save
  end

  test 'should not save with wrong api_id' do
    channel = Channel.new
    channel.api_id = INVALID_KEY
    channel.video_type = VALID_VIDEO_TYPE
    assert_not channel.save
  end

  test 'should not save without video_type' do
    channel = Channel.new
    channel.api_id = VALID_CHANNEL_ID
    assert_not channel.save
  end

  test 'should not save with wrong video_type' do
    channel = Channel.new
    channel.api_id = VALID_CHANNEL_ID
    channel.video_type = INVALID_KEY
    assert_not channel.save
  end

  test 'should save correct channel' do
    channel = create_correct_channel
    assert channel.save
  end

  test 'should not save existing channel' do
    channel = create_correct_channel
    channel.save
    channel = create_correct_channel
    assert_not channel.save
  end

  test 'should not validate uncorrect channel' do
    channel = create_correct_channel
    channel.save
    assert_not channel.owner_validated
    channel.validation_key = INVALID_KEY
    channel.save
    assert_not channel.owner_validated
  end

  test 'should validate correct channel' do
    channel = create_correct_channel
    channel.save
    channel = Channel.last
    channel.validation_key = VALID_VALIDATION_KEY
    channel.save
    assert channel.owner_validated
  end
end

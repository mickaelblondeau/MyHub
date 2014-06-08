require 'test_helper'

class VideoCategoryTest < ActiveSupport::TestCase
  test 'should not save without video id' do
    video_category = VideoCategory.new
    video_category.category_id = 1
    assert_not video_category.save
  end

  test 'should not save without category id' do
    video_category = VideoCategory.new
    video_category.video_id = 1
    assert_not video_category.save
  end

  test 'should save' do
    video_category = VideoCategory.new
    video_category.category_id = 1
    video_category.video_id = 1
    assert video_category.save
  end
end

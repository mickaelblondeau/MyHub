require 'test_helper'

class UserViewTest < ActiveSupport::TestCase
  def create_user_view
    user_view = UserView.new
    user_view.user_id = 1
    user_view.video_id = 1
    user_view
  end

  test 'should not save without video' do
    user_view = UserView.new
    user_view.user_id = 1
    assert_not user_view.save
  end

  test 'should not save without user' do
    user_view = UserView.new
    user_view.video_id = 1
    assert_not user_view.save
  end

  test 'should save with video & user' do
    user_view = create_user_view
    assert user_view.save
  end

  test 'should not save duplicates' do
    user_view = create_user_view
    assert user_view.save
    user_view = create_user_view
    assert_not user_view.save
  end
end

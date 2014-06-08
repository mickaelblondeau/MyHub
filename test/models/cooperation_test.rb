require 'test_helper'

class CooperationTest < ActiveSupport::TestCase
  test 'should not save without user id' do
    cooperation = Cooperation.new
    cooperation.channel_id = 1
    assert_not cooperation.save
  end

  test 'should not save without channel id' do
    cooperation = Cooperation.new
    cooperation.user_id = 1
    assert_not cooperation.save
  end

  test 'should save' do
    cooperation = Cooperation.new
    cooperation.channel_id = 1
    cooperation.user_id = 1
    assert cooperation.save
  end
end

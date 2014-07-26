require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def create_message
    message = Message.new
    message.owner_id = 1
    message.user_id = 2
    message.message = 'test'
    message
  end

  test 'should not save without owner' do
    message = Message.new
    message.user_id = 2
    message.message = 'test'
    assert_not message.save
  end

  test 'should not save without user' do
    message = Message.new
    message.owner_id = 1
    message.message = 'test'
    assert_not message.save
  end

  test 'should not save without message' do
    message = Message.new
    message.owner_id = 1
    message.user_id = 2
    assert_not message.save
  end

  test 'should save' do
    message = create_message
    assert message.save
  end
end

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  test 'should not save without label' do
    permission = Permission.new
    assert_not permission.save
  end

  test 'should save' do
    permission = Permission.new
    permission.label = 'test'
    assert permission.save
  end
end

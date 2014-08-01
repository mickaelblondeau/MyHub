require 'test_helper'

class CooperationPermissionTest < ActiveSupport::TestCase
  test 'should not save without user id' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.permission_id = 1
    cooperation_permission.playlist_id = 1
    assert_not cooperation_permission.save
  end

  test 'should not save without playlist id' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.permission_id = 1
    cooperation_permission.user_id = 1
    assert_not cooperation_permission.save
  end

  test 'should not save without permission id' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.playlist_id = 1
    cooperation_permission.user_id = 1
    assert_not cooperation_permission.save
  end

  test 'should save' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.playlist_id = 1
    cooperation_permission.user_id = 1
    cooperation_permission.permission_id = 1
    assert cooperation_permission.save
  end
end

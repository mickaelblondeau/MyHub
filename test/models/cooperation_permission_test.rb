require 'test_helper'

class CooperationPermissionTest < ActiveSupport::TestCase
  test 'should not save without cooperation id' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.cooperation_id = 1
    assert_not cooperation_permission.save
  end

  test 'should not save without permission id' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.permission_id = 1
    assert_not cooperation_permission.save
  end

  test 'should save' do
    cooperation_permission = CooperationPermission.new
    cooperation_permission.cooperation_id = 1
    cooperation_permission.permission_id = 1
    assert cooperation_permission.save
  end
end

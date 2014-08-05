class CooperationPermission < ActiveRecord::Base
  validates :user_id, :playlist_id, :permission, presence: true
  belongs_to :user
  belongs_to :playlist

  PERMISSIONS = {
      0 => 'permissions.post_serie',
      1 => 'permissions.manage_comment',
      2 => 'permissions.edit_serie',
  }

  def self.user_can(permission, user, playlist)
    CooperationPermission.where('user_id = ? AND playlist_id = ? AND permission = ?', user, playlist, permission).first
  end
end
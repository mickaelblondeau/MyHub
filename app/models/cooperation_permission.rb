class CooperationPermission < ActiveRecord::Base
  validates :user_id, :playlist_id, :permission, presence: true
  belongs_to :user
  belongs_to :playlist

  PERMISSIONS = { 0 => 'post-serie', 1 => 'test' }
end

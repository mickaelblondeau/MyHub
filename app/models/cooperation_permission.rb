class CooperationPermission < ActiveRecord::Base
  validates :user_id, :playlist_id, :permission_id, presence: true
  belongs_to :user
  belongs_to :playlist
  belongs_to :permission
end

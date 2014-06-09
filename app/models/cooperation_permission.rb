class CooperationPermission < ActiveRecord::Base
  validates :user_id, :channel_id, :permission_id, presence: true
  belongs_to :user
  belongs_to :channel
  belongs_to :permission
end

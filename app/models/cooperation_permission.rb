class CooperationPermission < ActiveRecord::Base
  validates :cooperation_id, :permission_id, presence: true
  belongs_to :cooperation
  belongs_to :permission
end

class CooperationPermission < ActiveRecord::Base
  belongs_to :cooperation
  belongs_to :permission
end

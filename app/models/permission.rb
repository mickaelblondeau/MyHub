class Permission < ActiveRecord::Base
  validates :label, presence: true
end

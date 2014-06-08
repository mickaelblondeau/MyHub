class Cooperation < ActiveRecord::Base
  validates :user_id, :channel_id, presence: true
  belongs_to :user
  belongs_to :channel
end

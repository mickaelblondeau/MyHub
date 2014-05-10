class VideoCategory < ActiveRecord::Base
  validates :video_id, :category_id, presence: true
  belongs_to :video
  belongs_to :category
end

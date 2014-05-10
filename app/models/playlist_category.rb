class PlaylistCategory < ActiveRecord::Base
  validates :playlist_id, :category_id, presence: true
  belongs_to :playlist
  belongs_to :category
end

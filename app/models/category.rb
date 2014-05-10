class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories
  has_many :playlist_categories
  has_many :playlists, through: :playlist_categories
end
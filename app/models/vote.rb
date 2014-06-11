class Vote < ActiveRecord::Base
  validates_presence_of :playlist_id, :unless => :video_id?
  validates_presence_of :video_id, :unless => :playlist_id?
  belongs_to :user
  belongs_to :playlist
  belongs_to :video

  before_create do
    if vote_exist
      return false
    end
  end

  def vote_exist
    exist = Vote.where('user_id = ? AND weekly IS NOT NULL AND (playlist_id = ? OR video_id = ?)', user_id, playlist_id, video_id).first
  end

  def get_type
    if video
      video
    else
      playlist
    end
  end
end

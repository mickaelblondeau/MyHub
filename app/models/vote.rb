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
    Vote.where('user_id = ? AND weekly IS NOT NULL AND (playlist_id = ? OR video_id = ?)', user_id, playlist_id, video_id).first
  end

  def change_vote
    v = vote_exist
    if v
      if vote == v.vote
        v.destroy
        v.get_params
      else
        v.vote = vote
        v.save
        v.get_params
      end
    else
      false
    end
  end

  def get_type
    if video
      video
    else
      playlist
    end
  end

  def self.get_params(object, current_user)
    vote = nil
    if object.class == Video
      { :param_name => :video_id, :id => object.id, :votes => Vote.where('video_id = ?', object.id) }
    else
      { :param_name => :playlist_id, :id => object.id, :votes => Vote.where('playlist_id = ?', object.id) }
    end
  end

  def get_params
    if video
      { :param_name => :video_id, :id => video.id, :votes => Vote.where('video_id = ?', video.id) }
    else
      { :param_name => :playlist_id, :id => playlist.id, :votes => Vote.where('playlist_id = ?', playlist.id) }
    end
  end
end

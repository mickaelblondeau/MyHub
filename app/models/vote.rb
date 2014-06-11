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

  def self.get_params(object, current_user)
    vote = nil
    if object.class == Video
      if current_user
        vote = Vote.where('video_id = ? AND user_id = ?', object.id, current_user.id).first
      end
      { :param_name => :video_id, :object => object, :votes => Vote.where('video_id = ?', object.id), :vote => vote }
    else
      if current_user
        vote = Vote.where('playlist_id = ? AND user_id = ?', object.id, current_user.id).first
      end
      { :param_name => :playlist_id, :object => object, :votes => Vote.where('playlist_id = ?', object.id), :vote => vote }
    end
  end

  def get_params
    if video
      { :param_name => :video_id, :object => video, :votes => Vote.where('video_id = ?', video.id), :vote => self }
    else
      { :param_name => :playlist_id, :object => playlist, :votes => Vote.where('playlist_id = ?', playlist.id), :vote => self }
    end
  end

  def get_delete_params
    params = get_params
    params[:vote] = nil
    params
  end
end

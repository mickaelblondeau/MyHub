class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates_presence_of :playlist_id, :unless => :video_id?
  validates_presence_of :video_id, :unless => :playlist_id?
  belongs_to :user
  belongs_to :video
  belongs_to :playlist

  def get_type
    if video
      video
    else
      playlist
    end
  end

  def get_type_owner
    if video
      video.channel.user
    else
      playlist.user
    end
  end

  def self.get_params(object)
    if object.class == Video
      { :param_name => :video_id, :id => object.id, :comments => Comment.where('video_id = ?', object.id).order('created_at DESC') }
    else
      { :param_name => :playlist_id, :id => object.id, :comments => Comment.where('playlist_id = ?', object.id).order('created_at DESC') }
    end
  end

  def get_params
    if video
      { :param_name => :video_id, :id => video.id, :comments => Comment.where('video_id = ?', video.id).order('created_at DESC') }
    else
      { :param_name => :playlist_id, :id => playlist.id, :comments => Comment.where('playlist_id = ?', playlist.id).order('created_at DESC') }
    end
  end
end
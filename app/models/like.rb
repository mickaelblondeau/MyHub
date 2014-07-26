class Like < ActiveRecord::Base
  validates_presence_of :playlist_id, :unless => :user_id?
  validates_presence_of :user_id, :unless => :playlist_id?
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user
  belongs_to :playlist
  has_many :user_videos, through: :user, source: :videos
  has_many :playlist_videos, through: :playlist, source: :videos
  attr_accessor :unseen_videos
  attr_accessor :last_video

  before_create do
    exist = Like.where('owner_id = ? AND (user_id = ? OR playlist_id = ?)', owner_id, user_id, playlist_id).first
    if exist
      false
    end
  end

  def get_type
    if playlist
      playlist
    else
      user
    end
  end

  def get_type_name
    if playlist
      playlist.title
    else
      user.user_name
    end
  end

  def get_videos
    if playlist
      playlist_videos
    else
      user_videos
    end
  end

  def get_views
    count = 0
    get_videos.each do |video|
      count += video.impressionist_count
    end
    count
  end

  def generate_unseen_count(user_id)
    self.unseen_videos = 0
    get_videos.each do |video|
      if video.not_seen_by(user_id)
        self.unseen_videos = self.unseen_videos + 1
      end
      if !last_video || video.created_at > last_video
        self.last_video = video.created_at
      end
    end
  end

  def get_unseen_videos(user_id = (user || user.id) ? user.id : nil)
    vids = get_videos
    vids.each do |video|
      if video.not_seen_by(user_id)
        video.seen = 0
      else
        video.seen = 1
      end
    end
    vids.sort_by {|v| [v.seen, -v.created_at.to_i]}
  end

  def self.sort_likes(likes, user_id)
    likes.each do |like|
      like.generate_unseen_count(user_id)
    end
    likes.sort_by {|l| [-l.unseen_videos, -l.last_video.to_i]}
  end

  def self.get_unseen_count(user_id)
    unseen_vids = []
    count = 0
    Like.where('owner_id = ?', user_id).includes(:user_videos, :playlist_videos).each do |like|
      like.get_videos.each do |video|
        if video.not_seen_by(user_id) && !unseen_vids.include?(video.id)
          unseen_vids.push(video.id)
          count = count + 1
        end
      end
    end
    count
  end

  def self.get_params(object, current_user)
    like = nil
    if object.class == User
      if current_user
        like = Like.where('user_id = ? AND owner_id = ?', object.id, current_user.id).first
      end
      { :param_name => :user_id, :id => object.id, :like => like }
    else
      if current_user
        like = Like.where('playlist_id = ? AND owner_id = ?', object.id, current_user.id).first
      end
      { :param_name => :playlist_id, :id => object.id, :like => like }
    end
  end

  def get_params
    if user
      { :param_name => :user_id, :id => user.id, :like => self }
    else
      { :param_name => :playlist_id, :id => playlist.id, :like => self }
    end
  end

  def get_delete_params
    params = get_params
    params[:like] = nil
    params
  end
end
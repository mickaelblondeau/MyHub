class Like < ActiveRecord::Base
  validates_presence_of :playlist_id, :unless => :user_id?
  validates_presence_of :user_id, :unless => :playlist_id?
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user
  belongs_to :playlist

  before_create do
    exist = Like.where('owner_id = ? AND (user_id = ? OR playlist_id = ?)', owner_id, user_id, playlist_id).first
    if exist
      return false
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
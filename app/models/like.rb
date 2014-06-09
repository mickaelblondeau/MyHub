class Like < ActiveRecord::Base
  validates_presence_of :playlist_id, :unless => :user_id?
  validates_presence_of :user_id, :unless => :playlist_id?
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user
  belongs_to :playlist

  before_create do
    exist = Like.where('owner_id = ? AND (user_id = ? OR playlist_id = ?)', owner_id, user_id, playlist_id)
    if exist.count > 0
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
end
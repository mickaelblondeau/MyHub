class Like < ActiveRecord::Base
  belongs_to :owner, foreign_key: :owner_id, class_name: :User
  belongs_to :user
  belongs_to :playlist
  belongs_to :video

  def get_type
    if video
      video
    elsif playlist
      playlist
    else
      user
    end
  end

  def get_type_name
    if video
      video.name
    elsif playlist
      playlist.title
    else
      user.user_name
    end
  end
end
class Participation < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :playlist
  belongs_to :video

  def get_type
    if video
      video
    else
      playlist
    end
  end

  def get_type_owner
    if channel
      channel.user
    else
      playlist.user
    end
  end
end

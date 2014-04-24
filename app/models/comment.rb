class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :user
  belongs_to :channel
  belongs_to :video
  belongs_to :playlist

  def get_type
    if channel
      channel
    elsif video
      video
    else
      playlist
    end
  end

  def get_type_owner
    if channel
      channel.user
    elsif video
      video.channel.user
    else
      playlist.user
    end
  end
end

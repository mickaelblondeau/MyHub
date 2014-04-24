class Article < ActiveRecord::Base
  validates :content, :title, presence: true
  belongs_to :user
  belongs_to :channel
  belongs_to :playlist

  def get_type
    if channel
      channel
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

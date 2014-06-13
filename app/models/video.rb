class Video < ActiveRecord::Base
  validates :api_id, :playlist_id, :channel_id, presence: true
  belongs_to :channel
  belongs_to :playlist
  has_many :video_categories, :dependent => :destroy
  has_many :categories, through: :video_categories
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  is_impressionable

  before_create do
    if !channel
      return false
    end
    if Video.where('videos.api_id = ?', api_id).joins(:channel).where(channels: { video_type: channel.video_type }).first
      return false
    end

    data = Api.video_info(api_id, channel.video_type)
    if data && data[:channel] == channel.api_id
      self.name = data[:name]
      self.description = data[:description]
      self.image = data[:image]
      self.created_at = data[:created_at]
      self.status = data[:status]
      return true
    else
      return false
    end
  end

  def update_meta
    data = Api.video_info(api_id, channel.video_type)
    if data && data[:channel] == channel.api_id && status != data[:status]
      self.status = data[:status]
      save
    end
  end

  def get_player
    if channel.video_type == 'yt'
      return ('<iframe src="//www.youtube.com/embed/' + api_id + '?rel=0" allowfullscreen height="360" width="640" frameborder="0"></iframe>').html_safe
    elsif channel.video_type == 'dm'
      return ('<iframe src="//www.dailymotion.com/embed/video/' + api_id + '" allowfullscreen height="360" width="640" frameborder="0"></iframe>').html_safe
    elsif channel.video_type == 'vi'
      return ('<iframe src="//player.vimeo.com/video/' + api_id + '" allowfullscreen height="360" width="640" frameborder="0"></iframe>').html_safe
    end
  end

end

class Video < ActiveRecord::Base
  validates :api_id, :playlist_id, presence: true
  belongs_to :channel
  belongs_to :playlist
  has_many :video_categories
  has_many :categories, through: :video_categories

  before_create do
    data = Api.video_info(api_id, channel.video_type)
    if data && data[:channel] == channel.api_id
      self.name = data[:name]
      self.description = data[:description]
      self.image = data[:image]
      self.created_at = data[:created_at]
      return true
    else
      return false
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

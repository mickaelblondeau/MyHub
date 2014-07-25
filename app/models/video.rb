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

  def diff_time
    diff_in_sec = ((DateTime.now - DateTime.parse(created_at.to_s)) * 1.days).to_i
    if diff_in_sec < 3600
      I18n.t('general.minutes', value: (diff_in_sec/60).to_s)
    elsif diff_in_sec < 86400
      I18n.t('general.hours', value: (diff_in_sec/60/60).to_s)
    elsif diff_in_sec < 2592000
      I18n.t('general.days', value: (diff_in_sec/60/60/24).to_s)
    elsif diff_in_sec < 31104000
      I18n.t('general.month', value: (diff_in_sec/60/60/24/30).to_s)
    else
      I18n.t('general.years', value: (diff_in_sec/60/60/24/30/12).to_s)
    end
  end

end

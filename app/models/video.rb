class Video < ActiveRecord::Base
  validates :api_id, :playlist_id, :channel_id, presence: true
  belongs_to :channel
  belongs_to :playlist
  has_many :video_categories, :dependent => :destroy
  has_many :categories, through: :video_categories
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  is_impressionable :counter_cache => true, :unique => true
  attr_accessor :seen

  def to_param
    Encoder::encode_id(id)
  end

  before_create do
    if !channel || Video.where('videos.api_id = ?', api_id).joins(:channel).where(channels: { video_type: channel.video_type }).first
      false
    else
      data = Api.video_info(api_id, channel.video_type)
      if data && data[:channel] == channel.api_id
        self.name = data[:name]
        self.description = data[:description]
        self.image = data[:image]
        self.created_at = data[:created_at]
        self.status = data[:status]
        true
      else
        false
      end
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
      ('<iframe src="//www.youtube.com/embed/' + api_id + '?rel=0" allowfullscreen height="480" width="100%" frameborder="0"></iframe>').html_safe
    elsif channel.video_type == 'dm'
      ('<iframe src="//www.dailymotion.com/embed/video/' + api_id + '" allowfullscreen height="480" width="100%" frameborder="0"></iframe>').html_safe
    elsif channel.video_type == 'vi'
      ('<iframe src="//player.vimeo.com/video/' + api_id + '" allowfullscreen height="480" width="100%" frameborder="0"></iframe>').html_safe
    end
  end

  def diff_time
    Video.diff_time(created_at)
  end

  def self.diff_time(date)
    diff_in_sec = ((DateTime.now - DateTime.parse(date.to_s)) * 1.days).to_i
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

  def not_seen_by(user_id)
    !UserView.where('user_id = ? AND video_id = ?', user_id, id).first
  end
end
class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug
  belongs_to :user
  validates :api_id, :video_type, presence: true
  has_many :videos, -> { order 'created_at DESC' }, :dependent => :destroy

  SRC_HOST = { 'yt' => :Youtube, 'dm' => :Dailymotion, 'vi' => :Vimeo }

  def should_generate_new_friendly_id?
    new_record?
  end

  before_create do
    exist = Channel.where('api_id = ? AND video_type = ?', api_id, video_type).first
    if exist
      return false
    end

    data = Api.channel_info(api_id, video_type)
    if data
      self.validation_key = rand(36**10).to_s(36)
      self.api_id = data[:api_id]
      self.name = data[:name]
      self.image = data[:image]
      self.slug = data[:name]
      return true
    else
      return false
    end
  end

  def owner_validated
    data = Api.channel_info(api_id, video_type)
    if data && (validation_key && data[:description].include?(validation_key) || (user && user.is_admin))
      self.validated = true
      self.save
    end
  end

end

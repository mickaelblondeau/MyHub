class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug
  belongs_to :user
  validates :api_id, presence: true

  SRC_HOST = { 'yt' => :Youtube, 'dm' => :Dailymotion, 'vi' => :Vimeo }

  before_create do
    data = Api.channel_info(api_id, video_type)
    if data
      self.validation_key = rand(36**10).to_s(36)
      self.api_id = data[:api_id]
      self.name = data[:name]
      self.description = data[:description]
      self.image = data[:image]
      self.slug = data[:name]
      return true
    else
      return false
    end
  end

  def owner_validated
    data = Api.channel_info(api_id, video_type)
    if data
      if data[:description].include? validation_key
        self.validated = true
        self.save
      end
    end
  end

end

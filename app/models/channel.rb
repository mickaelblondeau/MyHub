class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged
  belongs_to :user
  validates :api_id, :video_type, presence: true
  has_many :videos, -> { order 'created_at DESC' }, :dependent => :destroy

  SRC_HOST = { 'yt' => :Youtube, 'dm' => :Dailymotion, 'vi' => :Vimeo }

  def slug_candidates
    [
        :name,
        [:id, :name]
    ]
  end

  def save_with_slug
    if save
      self.slug = nil
      save
    else
      false
    end
  end

  before_create do
    if find_existing
      false
    end

    data = Api.channel_info(api_id, video_type)
    if data
      self.validation_key = rand(36**10).to_s(36)
      self.api_id = data[:api_id]
      self.name = data[:name]
      self.image = data[:image]
      self.slug = data[:name]
      true
    else
      false
    end
  end

  def find_existing
    Channel.where('api_id = ? AND video_type = ? AND validated IS TRUE', api_id, video_type).first
  end

  def owner_validated
    data = Api.channel_info(api_id, video_type)
    if data && (validation_key && data[:description].include?(validation_key) || (user && user.is_admin))
      self.validated = true
      self.save
    end
  end

end

class Video < ActiveRecord::Base
  validates :api_id, :playlist_id, presence: true
  belongs_to :channel
  belongs_to :playlist
  belongs_to :category

  before_create do
    data = Api.video_info(api_id)
    if data['items'][0] && data['items'][0]['snippet'] &&
        data['items'][0]['snippet']['thumbnails'] &&
        data['items'][0]['snippet']['thumbnails']['default'] &&
        data['items'][0]['snippet']['channelId'] == channel.api_id
      self.name = data['items'][0]['snippet']['title']
      self.description = data['items'][0]['snippet']['description']
      self.image = data['items'][0]['snippet']['thumbnails']['default']['url']
      self.created_at= data['items'][0]['snippet']['publishedAt']
      return true
    else
      return false
    end
  end

end

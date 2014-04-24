class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug
  belongs_to :user
  validates :api_id, presence: true

  before_create do
    data = Api.channel_info(api_id)
    if data['items'][0] &&
        data['items'][0]['snippet'] &&
        data['items'][0]['snippet']['thumbnails'] &&
        data['items'][0]['snippet']['thumbnails']['default']
      self.validation_key = rand(36**10).to_s(36)
      self.name = data['items'][0]['snippet']['title']
      self.description = data['items'][0]['snippet']['description']
      self.image = data['items'][0]['snippet']['thumbnails']['default']['url']
      self.slug = data['items'][0]['snippet']['title']
      return true
    else
      return false
    end
  end

  def isValidated
    if validated
      return 'true'
    else
      return 'false'
    end
  end

  def ownerValidated
    data = Api.channel_info(api_id)
    if data['items'][0] &&
        data['items'][0]['snippet']
      description = data['items'][0]['snippet']['description']
      if description.include? validation_key
        self.validated = true
        self.save
      end
    end
  end

end

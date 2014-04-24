class Api
  require 'open-uri'
  API_ID = Rails.configuration.youtube_api_key
  URL = 'https://www.googleapis.com/youtube/v3/'

  def self.channel_info(id)
    url = URL + 'channels?part=snippet&id=' + id + '&fields=items%2Fsnippet&maxResults=1&key=' + API_ID
    Api::parse(url)
  end

  def self.video_info(id)
    url = URL + 'videos?part=snippet&id=' + id + '&fields=items%2Fsnippet&maxResults=1&key=' + API_ID
    Api::parse(url)
  end

  def self.parse(url)
    buffer = open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
    JSON.parse(buffer)
  end
end

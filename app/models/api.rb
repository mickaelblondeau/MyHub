class Api
  require 'open-uri'
  YOUTUBE_API = 'https://www.googleapis.com/youtube/v3/'
  DAILYMOTION_API = 'https://api.dailymotion.com/'
  VIMEO_API = 'http://vimeo.com/api/v2/'

  def self.channel_info(id, video_type)
    id.strip!
    if video_type == 'yt'
      url = YOUTUBE_API + 'channels?part=contentDetails%2C+snippet&id=' + id + '&fields=items(id%2Csnippet)&maxResults=1&key=' + Rails.configuration.youtube_api_key
      return Api::parseYTChannel(Api::parse(url))
    elsif video_type == 'dm'
      url = DAILYMOTION_API + 'user/' + id + '&fields=id,screenname,description,avatar_80_url'
      return Api::parseDMChannel(Api::parse(url))
    elsif video_type == 'vi'
      url = VIMEO_API + id + '/info.json'
      return Api::parseVIChannel(Api::parse(url))
    end
  end

  def self.parseYTChannel(data)
    if data &&
        data['items'] &&
        data['items'][0] &&
        data['items'][0]['snippet'] &&
        data['items'][0]['snippet']['thumbnails'] &&
        data['items'][0]['snippet']['thumbnails']['default']
        return {
            name: data['items'][0]['snippet']['title'],
            description: data['items'][0]['snippet']['description'],
            image: data['items'][0]['snippet']['thumbnails']['default']['url'],
            api_id: data['items'][0]['id']
        }
    else
      return false
    end
  end

  def self.parseDMChannel(data)
    if data
      return {
          name: data['screenname'],
          description: data['description'],
          image: data['avatar_80_url'],
          api_id: data['id']
      }
    else
      return false
    end
  end

  def self.parseVIChannel(data)
    if data
      return {
          name: data['display_name'],
          description: data['bio'],
          image: data['portrait_medium'],
          api_id: data['id']
      }
    else
      return false
    end
  end

  def self.video_info(id, video_type)
    id.strip!
    if video_type == 'yt'
      url = YOUTUBE_API + 'videos?part=snippet&id=' + id + '&fields=items%2Fsnippet&maxResults=1&key=' + Rails.configuration.youtube_api_key
      return Api::parseYTVideo(Api::parse(url))
    elsif video_type == 'dm'
      url = DAILYMOTION_API + 'video/' + id + '&fields=owner,description,created_time,thumbnail_60_url,title'
      return Api::parseDMVideo(Api::parse(url))
    elsif video_type == 'vi'
      url = VIMEO_API + 'video/' + id + '.json'
      return Api::parseVIVideo(Api::parse(url))
    end
  end

  def self.parseYTVideo(data)
    if data && data['items'] && data['items'][0] && data['items'][0]['snippet'] &&
        data['items'][0]['snippet']['thumbnails'] &&
        data['items'][0]['snippet']['thumbnails']['default']
      return {
          name: data['items'][0]['snippet']['title'],
          description: data['items'][0]['snippet']['description'],
          image: data['items'][0]['snippet']['thumbnails']['default']['url'],
          created_at: data['items'][0]['snippet']['publishedAt'],
          channel: data['items'][0]['snippet']['channelId']
      }
    else
      return false
    end
  end

  def self.parseDMVideo(data)
    if data
      return {
          name: data['title'],
          description: data['description'],
          image: data['thumbnail_60_url'],
          created_at: data['created_time'],
          channel: data['user_id']
      }
    else
      return false
    end
  end

  def self.parseVIVideo(data)
    data = data[0]
    if data
      return {
          name: data['title'],
          description: data['description'],
          image: data['thumbnail_small'],
          created_at: data['upload_date'],
          channel: data['user_id'].to_s
      }
    else
      return false
    end
  end

  def self.parse(url)
    begin
      buffer = open(url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
    rescue
      return false
    end
    JSON.parse(buffer)
  end
end

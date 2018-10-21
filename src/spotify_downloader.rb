# frozen_string_literal: true

require_relative 'spotify/client'

class SpotifyDownloader

  def initialize(options = {})
    @google_token  = options.fetch("google_token")
    @spotify_token = options.fetch("spotify_token")
    @download_path = options.fetch("download_path")
    @debug         = options.fetch("debug") { false }
  end

  def download!(playlist_id)
    @playlist_id = playlist_id
    create_folder!
    download_playlist!
    return
  end

  private

  def download_playlist!
    @bar = ::TaskProgressBar.new(playlist_items.count) if !@debug
    playlist_items.each do |item|
      @bar.step() if !@debug
      mp3_download!(item)
    end
  end

  def client
    @client ||= ::Spotify::Client.new({ access_token: @spotify_token })
  end

  def playlist
    begin
      @playlist ||= client.playlist(@playlist_id)
    rescue => e
      puts e if @debug
    end
  end

  def playlist_name
    @playlist_name ||= playlist['name']
  end

  def playlist_items
    playlist['tracks']['items']
  end

  def create_folder!
    `cd #{@download_path} && mkdir '#{playlist_name}'`.chomp
  end

  def spotify_title(item)
    "#{item['track']['name']} #{item['track']['artists'].first['name']}"
  end

  def google_params(item)
    {
      key:        @google_token,
      q:          spotify_title(item),
      part:       'snippet',
      maxResults: '1'
    }
  end

  def google_uri(item)
    URI('https://www.googleapis.com/youtube/v3/search?'+URI.encode_www_form(google_params(item)))
  end

  def fetch_google_api(item)
    begin
      JSON.parse(Net::HTTP.get( google_uri(item) ))
    rescue => e
    end
  end

  def google_title(video_data)
    video_data['items'].first['snippet']['title']
  end

  def google_video_id(video_data)
    video_data['items'].first['id']['videoId']
  end

  def print_debug(item, video_data)
    return if !@debug
    puts '-----------'
    puts "Spotify: " + spotify_title(item)
    puts "Youtube: " + google_title(video_data)
  end

  def mp3_download!(item)
    begin
      video_data = fetch_google_api(item)
      title      = google_title(video_data)
      video_id   = google_video_id(video_data)
      print_debug(item, video_data)
      `cd #{@download_path} && cd '#{playlist_name}' && youtube-dl -x --no-check-certificate --no-progress --audio-format mp3 --console-title https://www.youtube.com/watch?v=#{video_id}`.chomp
    rescue => ex
    end
  end

end

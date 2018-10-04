# frozen_string_literal: true

# sudo apt install youtube-dl ffmpeg -y
# gem install spotify-client
# gem install task_progress_bar
# SPOTIFY_API - TOKEN - https://developer.spotify.com/console/get-playlist-tracks/?playlist_id=37i9dQZEVXbMXbN3EUUhlg
# GOOGLE_API  - TOKEN - https://console.developers.google.com/apis/library/youtube.googleapis.com

require 'uri'
require 'net/http'
require 'spotify-client'
require 'task_progress_bar'
require_relative 'src/spotify_downloader'

config = {
  download_path: '~/Music/',
  spotify_token: 'BQCfpUC7gnGgoxSxvtUMThLA96PI3Ly-rULnIFharAZOoFMenT9jauF_FBloBH6aiB3IVYESUF_qnmy-ZHOnml95u0WpBjoi4xJT85adxCs4QdomMlPOJbC88eCKMkD50gpNWbLKjG0ILtidlD4',
  google_token:  'AIzaSyAv0itwIjlbcTNaEzVH4ai6SH5fqhDx0S8'
}

client = SpotifyDownloader.new(config)
client.download!('37i9dQZF1DWSIvbYYt1Dvi')

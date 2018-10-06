# frozen_string_literal: true

# sudo apt install youtube-dl ffmpeg -y
# gem install spotify-client
# gem install task_progress_bar
# SPOTIFY_API - TOKEN - https://developer.spotify.com/console/get-playlist-tracks/?playlist_id=37i9dQZEVXbMXbN3EUUhlg
# GOOGLE_API  - TOKEN - https://console.developers.google.com/apis/library/youtube.googleapis.com

require 'yaml'
require 'uri'
require 'net/http'
require 'spotify-client'
require 'task_progress_bar'
require_relative 'src/spotify_downloader'

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml'))

client = SpotifyDownloader.new(config)
client.download!('PLAYLIST-ID')

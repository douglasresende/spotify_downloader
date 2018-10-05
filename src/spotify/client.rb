# frozen_string_literal: true

module Spotify

  class Client

    def playlist(playlist_id)
      run!(:get, "/v1/playlists/#{playlist_id}", [200])
    end

  end

end

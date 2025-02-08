# Scrapes Spotify using a ruby API gem in order to retrieve a list of all the tracks in a specified playlist

require 'rspotify'
require 'awesome_print'
require 'uri'
require 'httparty'
require 'json'

puts 'Enter your Spotify developer client secret:'
CLIENT_ID = '31f98d9e224c4dc0afa39bc5f3e13e4e'
CLIENT_SECRET = gets.chomp

# RSpotify.authenticate CLIENT_ID, CLIENT_SECRET

auth = Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
token_response = HTTParty.post("https://accounts.spotify.com/api/token",
                               headers: {
                                 "Authorization" => "Basic #{auth}",
                                 "Content-Type" => "application/x-www-form-urlencoded"
                               },
                               body: "grant_type=client_credentials"
)

unless token_response.success?
  abort "Error obtaining token: #{token_response.code} #{token_response.body}"
end

access_token = token_response.parsed_response["access_token"]
puts "Manually obtained access token: #{access_token}"

# playlist_id = '2MSJ7DBDb72fPmKfY6kbs2'
puts 'Enter your Spotify playlist id (in the form of: https://open.spotify.com/playlist/<playlist_id>):'
playlist_id = gets.chomp

# Base URL for the Spotify API playlist tracks endpoint
base_url = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"

limit  = 100  # Maximum allowed per Spotify's API
offset = 0
all_tracks = []

loop do
  # Construct the URL with pagination parameters
  url = "#{base_url}?limit=#{limit}&offset=#{offset}"
  response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{access_token}" })

  # Check for a successful response
  unless response.success?
    abort "Error fetching tracks: #{response.code} - #{response.body}"
  end

  json = JSON.parse(response.body)
  items = json["items"]

  # Exit the loop if there are no more items
  break if items.nil? || items.empty?

  # Each item is a hash with a "track" key that holds the track data.
  items.each do |item|
    track_data = item["track"]
    all_tracks << RSpotify::Track.new(track_data)
  end

  offset += limit
  # Break the loop when the offset reaches (or exceeds) the total number of tracks.
  break if offset >= json["total"].to_i
end

# Output each track's name and its artist(s)
all_tracks.each_with_index do |track, i|
  artist_names = track.artists.map(&:name).join(', ')
  puts "#{i+1}. #{artist_names} - \"#{track.name}\""
end
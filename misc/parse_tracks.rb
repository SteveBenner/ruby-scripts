# This script was specially made to sort out my 3 lists of tracks for Sven's Ultimate Trance Playlist

require 'set'

# Common suffixes that should be ignored for better matching
COMMON_SUFFIXES = [
  "original mix", "extended mix", "radio edit", "club mix",
  "remix", "edit", "dub mix", "instrumental", "rework", "re-edit",
  "version", "vip mix", "live", "unreleased", "radio cut"
]

# Function to extract a clean track name
def clean_track_name(track_name)
  # Remove quoted parts if present in list3
  track_name = track_name.gsub(/["]/, '')

  # Remove text in parentheses (e.g., "(feat. Artist)", "(Remix)")
  track_name = track_name.gsub(/\(.*?\)/, '')

  # Normalize whitespace
  track_name = track_name.strip.downcase

  # Remove common suffixes (like "Original Mix")
  COMMON_SUFFIXES.each do |suffix|
    track_name = track_name.sub(/#{suffix}$/, '').strip
  end

  track_name
end

# Function to parse a file and extract track names
def parse_tracks(filename)
  tracks = {}
  File.readlines(filename, chomp: true).each do |line|
    next if line.strip.empty? # Skip empty lines

    parts = line.split(' - ', 2) # Split at the first hyphen
    next unless parts.length == 2 # Ensure valid format

    track_name = clean_track_name(parts[1]) # Normalize track name
    tracks[track_name] = line # Store original line with cleaned name as key
  end
  tracks
end

# File paths
list1_path = File.expand_path('~/Downloads/list1.txt')
list2_path = File.expand_path('~/Downloads/list2.txt')
list3_path = File.expand_path('~/Downloads/list3.txt')

# Parse all three lists
master_tracks = parse_tracks(list1_path)
youtube_tracks = parse_tracks(list2_path)
spotify_tracks = parse_tracks(list3_path)

# Combine all tracks to remove (normalize them first)
tracks_to_remove = youtube_tracks.keys.to_set.union(spotify_tracks.keys.to_set)

# Filter master list, keeping only tracks not found in YouTube or Spotify lists
filtered_tracks = master_tracks.reject { |track_name, _| tracks_to_remove.include?(track_name) }

# Output filtered tracks to the terminal
puts "Filtered Playlist:\n\n"
filtered_tracks.each_with_index { |(k,v), i| puts "#{i + 1}. #{v}" }
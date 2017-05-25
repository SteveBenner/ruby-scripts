#!/usr/bin/env ruby
# League of Legends network tools
#
# $1: number of pings (one per second)
#
require 'colorize'

color_lag = lambda do |ping|
  lag_color = case ping
    when 0..149 then :green
    when 150..299 then :yellow
    else :red
  end
  ping.to_s.colorize color: lag_color
end

# Data (source: http://forums.na.leagueoflegends.com/board/showthread.php?t=3134222)
SERVERS = %w[104.160.131.3 104.160.131.1 216.52.241.254 66.151.54.190 50.203.115.149 66.150.148.1]

# this is just for nice even terminal output...
longest_ip = SERVERS.max_by { |s| s.length }
SERVERS.collect! { |s| s << ' '*(longest_ip.length - s.length) }

lowest, highest = [], []
DEFAULT_NUM_PINGS = 120
PING_COUNT = ARGV.first || DEFAULT_NUM_PINGS

puts "Pinging #{SERVERS.count.to_s.white} servers concurrently, for #{PING_COUNT.to_s.white} seconds..."

# todo: figure out why this throws an ArgumentError for some reason, claiming `results` is Nil for the last thread
threads = SERVERS.collect do |server|
  Thread.new(server) do |server|
    begin
      results = `ping -c #{PING_COUNT} #{server}`.scan(/time=(\d*\.\d*)/).flatten.map! &:to_f
    rescue
      abort 'ERROR: Unable to form a connection; there may be a problem with your network.'
    end
    avg_latency = results.reduce(:+) / results.count.to_f
    lowest     << results.min
    highest    << results.max
    puts 'Pinging '.white + server.light_blue + ' ' + PING_COUNT.to_s.light_yellow +
          ' times resulted in average latency of: '.white + color_lag.call(avg_latency)
  end
end
threads.each &:join

puts 'Your lowest recorded ping was '.white + color_lag.call(lowest.min) +
     ' and your highest was '.white + color_lag.call(highest.max) + '.'
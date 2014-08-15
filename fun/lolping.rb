#!/usr/bin/env ruby
# League of Legends network tools
#
require 'colorize'

# todo: thread

# Data
SERVERS = [
	'216.52.241.254',
	'66.151.54.190',
	'50.203.115.149', # NA comcast server
	'66.150.148.1',   # NA, from: http://forums.na.leagueoflegends.com/board/showthread.php?t=3134222
	'64.7.194.1'      #
]
# this is just for nice even terminal output...
longest_ip = SERVERS.max_by { |s| s.length }
SERVERS.collect! { |s| s << ' '*(longest_ip.length - s.length) }

PING_COUNT = ARGV.first || 100
SERVERS.each do |server|
	results = `ping -c #{PING_COUNT} #{server}`.scan(/time=(\d*\.\d*)/)
	avg_latency = results.flatten.map(&:to_f).reduce(:+) / results.count.to_f
	color = case avg_latency
    when 0..200 then :cyan
    when 201..300 then :yellow
    else :red
  end
	puts "Pinging #{server.magenta} #{PING_COUNT.to_s.white} times resulted in "\
			 "average latency of: #{avg_latency.to_s.colorize(color: color)}"
end


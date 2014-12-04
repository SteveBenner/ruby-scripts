#!/usr/bin/env ruby
#
# A Pomodoro CLI timer
#
# @author Stephen Benner
#
require 'optparse'

# todo: parse options file
# Default options
# todo: set defaults
opts = {
	timer_duration: 30*60 # 30 minutes (time in seconds)
}
# Command line interface
optparser = OptionParser.new do |cli|
	cli.version = '0.0.1'
	cli.summary_width = 24
	cli.banner = 'Usage: pomodoro [OPTIONS] (when called without any options, displays timer status)'
	# command_str = $/ + 'Commands:' + COMMANDS.map { |name, desc| $/ + cli.summary_indent + name + summary_width + desc }
	# OPTIONS
	cli.on('-s', 'Starts or stops the timer') { opts[:cmd] = :toggle }
	cli.on('-t', '--time MINUTES', 'Sets the timer duration') do |t|
		opts[:timer_duration] = t * 60 # convert to seconds
		abort 'ERROR: Duration must be 1 minute or longer!' if t < 1
	end
	cli.on('-o', '--offtime MINUTES', 'Sets the break duration') { |o| opts[:break_duration] = t * 60 }
	cli.on('-p', '--pause', 'Pauses the timer') { opts[:cmd] = :pause }
	cli.on('-r', '--reset', 'Resets the timer') { opts[:cmd] = :reset }
	cli.on('-b', '--break', 'Starts a break immediately') { opts[:cmd] = :reset }
	cli.on_tail('-h', '--help', '--usage', 'Display this message') { puts cli; exit }
	cli.on_tail('--version', 'Display script version') { puts cli.version; exit }
end.parse!


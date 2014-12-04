#!/usr/bin/env ruby
#
# CLI tool
#
# @author Stephen Benner
#
require 'optparse'

# Commands
COMMANDS = {}
# Default options
opts = {}
# Command line interface
optparser = OptionParser.new do |cli|
	cli.version = '0.0.1'
	cli.summary_width = 24
	cli.banner = 'Usage: pomo [COMMAND] [OPTIONS]'
	command_str = $/ + 'Commands:' + COMMANDS.map { |name, desc| $/ + cli.summary_indent + name + summary_width + desc }
	# OPTIONS
	cli.on_tail('-h', '--help', '--usage', 'Display this message') { puts cli; exit }
	cli.on_tail('--version', 'Display script version') { puts cli.version; exit }
end.parse!


#!/usr/bin/env ruby
#
# CLI tool for adding a user to your OS X system
# Wraps Directory Services CLI tool `dscl`
# 
# @author Stephen Benner
# https://github.com/SteveBenner
#
require 'optparse'

# Default options
opts = {
	
}
# Command line interface
optparser = OptionParser.new do |cli|
  cli.version = '0.0.1'
	cli.summary_width  = 24
	cli.summary_indent = ' ' * 2
	cli.banner = 'CLI tool for adding a user to your OS X system'
	# OPTIONS GO HERE
	cli.on_tail('-h', '--help', '--usage', 'Display this message.') { puts cli; exit }
  cli.on_tail('--version', 'Display script version.') { puts cli.version; exit }
end.parse!

#!/usr/bin/env ruby
#
# CLI tool for adding a user to an OS X system
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
  cli.banner = 'CLI tool for adding a user to your OS X system' + $/ +
	  'Usage: adduser [options] USERNAME'
  cli.on('-f', '--full-name', 'Full name for user') { |name| opts[:RealName] = name }
  cli.on('-s', '--shell', 'Shell for user') { |path| opts[:UserShell] = path }
  cli.on('-i', '--id', 'UniqueID of user (must be unique)') { |id| opts[:UniqueID] = id }
  cli.on('-g', '--group-id', 'Group ID of user') { |id| opts[:PrimaryGroupID] = id }
  cli.on('-a', '--admin', 'Makes the user an administrator') { opts[:admin] = true}
  cli.on('-p', '--password', 'Password for user') { |pw| opts[:password] = pw}
  cli.on_tail('-h', '--help', '--usage', 'Display this message.') { puts cli; exit }
  cli.on_tail('--version', 'Display script version.') { puts cli.version; exit }
end.parse!

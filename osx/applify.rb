#!/usr/bin/env ruby
#
# Amplify your control over OS X apps
# 
# @author Stephen Benner
# https://github.com/SteveBenner
#
require 'optparse'
require 'pathname'

# Default options
opts      = {}
# Command line interface
optparser = OptionParser.new do |cli|
  cli.version        = '0.0.1'
  cli.summary_width  = 24
  cli.summary_indent = ' ' * 2
  cli.on_tail('-h', '--help', '--usage', 'Display this message.') { puts cli; exit }
  cli.on_tail('--version', 'Display script version.') { puts cli.version; exit }
  cli.banner = <<-HEREDOC
    Configure OS X applications. Usage: <application> [options]
    Options:
  HEREDOC
end.parse!

# todo

#!/usr/bin/env ruby
#
# Copy files to a local backup directory
# 
# @author Stephen Benner
#
require 'optparse'
require 'pathname'
require 'fileutils'

# Default options
opts = {dir: '~/.backup', verbose: false}
# Command line interface
optparser = OptionParser.new do |cli|
	cli.version = '0.0.1'
	cli.summary_width = 24
	cli.banner = "Usage: backup [OPTIONS] [FILES]" + $/ + 'NOTE: Absolute paths must be used when passing in files!'
	# OPTIONS
	cli.on('-d', '--dir', 'Specify the directory to create backup files in') { |o| opts[:dir] = o }
	cli.on('-v', '--verbose', 'Print results of file operations') { |o| opts[:verbose] = o }
	cli.on_tail('-h', '--help', '--usage', 'Display this message') { puts cli; exit }
	cli.on_tail('--version', 'Display script version') { puts cli.version; exit }
end.parse!

BACKUP_DIR = Pathname(opts[:dir]).expand_path.realpath
Pathname.mkpath BACKUP_DIR unless BACKUP_DIR.directory?

# Note that ARGV is avoided; this is because we want to accept input via Unix pipes
$stdin.each do |file|
	abort 'ERROR: All given file paths must be absolute!!!' unless file.absolute?
	abort "ERROR: Invalid file: #{file}" unless file.file?
	FileUtils.cp_r file, BACKUP_DIR, opts.delete(:dir)
end
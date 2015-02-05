#!/usr/bin/env ruby
#
# Copy files to a local backup directory
# 
# @author Stephen Benner
#
# todo: add ENV var for setting dir
require 'optparse'
require 'pathname'
require 'fileutils'

# Default options
opts = {dir: Pathname('~/.backup/').expand_path, verbose: false}
# Command line interface
optparser = OptionParser.new do |cli|
  cli.version = '0.0.1'
  cli.summary_width = 24
  cli.banner = 'Usage: backup [OPTIONS] [FILES]'
  note = 'NOTE: Absolute paths must be used when passing in files!'
  # OPTIONS
  cli.on('-d', '--dir=PATH', 'Specify the directory to create backup files in (relative to: ~/.backup/)') do |d|
    opts[:dir] = Pathname d
  end
  cli.on('-v', '--verbose', 'Print results of file operations') { |o| opts[:verbose] = o }
  cli.on_tail('-h', '--help', '--usage', 'Display this message') { puts cli; puts note; exit }
  cli.on_tail('--version', 'Display script version') { puts cli.version; exit }
end.parse!

# If an absolute path is given, use that; otherwise assume it is relative from the default location
DEFAULT_BACKUP_DIR = Pathname('~/.backup/').expand_path
BACKUP_DIR = opts[:dir].absolute? ? opts[:dir] : DEFAULT_BACKUP_DIR.join(opts[:dir])
BACKUP_DIR.mkpath unless BACKUP_DIR.directory?

# Note that ARGV is avoided; this is because we want to accept input via Unix pipes
$stdin.each do |f|
  file = Pathname f.chomp
  abort "ERROR: All file paths must be absolute! Relative path detected: #{f}" unless file.absolute?
  abort "ERROR: Invalid file: #{file}" unless file.file?
  fileopts = opts.select { |k,v| k =~ /preserve|noop|verbose|dereference_root|remove_destination/ }
  FileUtils.cp_r file, BACKUP_DIR, fileopts
end

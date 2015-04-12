#!/usr/bin/env ruby
#
# A wrapper for the Mac OS X 'split' CLI tool for splitting a file into parts
# 
# @author Stephen Benner
# https://github.com/SteveBenner
#
require 'optparse'

FILENAME = ARGV.shift

# Default options
opts = {
	byte_count: nil,
	dir: FILENAME
}
# Command line interface
optparser = OptionParser.new do |cli|
	cli.version = '0.0.1'
	cli.summary_width = 24
	cli.banner = "A wrapper for the Mac OS X 'split' CLI tool for splitting a file into parts"
	# required options (or semi-required)
	cli.on('-p', '--parts', 'Number of parts to divide the file into, based on file size.') do |parts|
		bytes = File.new(File.expand_path FILENAME).size
		opts[:byte_count] = bytes / parts
	end
	cli.on('-s', '--size', "Size of each file part, specified in bytes, or larger by appending 'k', 'm', or 'g'
to the end of the number.") do |size|
		opts[:byte_count] = case size[-1]
			when 'k' then size.chop * 1024
			when 'm' then size.chop * 1024 * 1024
			when 'g' then size.chop * 1024 * 1024 * 1024
			else size
		end
	end
	cli.on('-k', 'Size of each file part in Kilobytes') { |size| opts[:byte_count] = size * 1024 }
	cli.on('-m', 'Size of each file part in Megabytes') { |size| opts[:byte_count] = size * 1024 * 1024 }
	cli.on('-g', 'Size of each file part in Gigabytes') { |size| opts[:byte_count] = size * 1024 * 1024 * 1024 }
	# optional
	# todo: flesh out this description a bit more
	cli.on('-i', '--increment', 'Pattern representing the string appended to each successful file created.') do |pattern|
		opts[:increment_suffix] = pattern.chop + case pattern[-2..-1]
			when '%i' then
			else ''
		end
	end
	cli.on('-p', '--prefix', 'Prepend given prefix followed by a hyphen to all created files.') { |p| opts[:prefix] = p }
	cli.on('-s', '--suffix', 'Append a hyphen followed by given suffix to all created files.') { |p| opts[:suffix] = p }
	cli.on('-d', '--dir', 'Store created files in given directory, creating it if nonexistent.') do |dirname|
		opts[:dir] = dirname
	end
	cli.on('-nd', '--no-dir', 'Create files in the current working directory.') { opts[:dir] = false }
	cli.on_tail('-h', '--help', '--usage', 'Display this message.') { puts cli; exit }
	cli.on_tail('--version', 'Display script version.') { puts cli.version; exit }
end.parse!


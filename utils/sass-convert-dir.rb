#!/usr/bin/env ruby
#
# Recursively converts SASS files to alternate syntax
#
# @author Stephen Benner
#
DIR = '<project-root>'
files = Dir.glob("#{DIR}/**/*.scss")
files.each { |f| `sass-convert #{f} #{f.sub(/\.scss/, '.sass')}` unless File.exist?(f.sub(/\.scss/, '.sass')) }

# one-liner for CLI use
# ruby -e "Dir.glob('<project-root>/**/*.scss').each { |f| `sas®s-convert #{f} #{f.sub(/\.scss/, '.sass')}` unless File.exist?(f.sub(/\.scss/, '.sass')) }"
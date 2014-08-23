#!/usr/bin/env ruby
#
# This script generates a markdown README containing image links to
# all of the image files in the current working directory (or path
# specified by an argument to the script). The links are sorted by
# dimension; to accomplish this, each file must be suffixed with a
# hyphen followed by the size of their largest dimension.
# Example: '<filename>-<size-in-pixels>.jpg'
#
# The script will also look for a file in the working directory
# named 'LEGAL' or 'COPYRIGHT' and will add it to the README file
# if one is found.
#
Dir.chdir ARGV.first if ARGV.first

TITLE = 'App Icons'
LEGAL_FILE = Dir.glob('{LEGAL,COPYRIGHT}.*').first

images = Dir.glob("*.{png,jpg}").reduce({}) do |list, img|
	# divide files into arrays - one for each unique img size
	if img =~ /-(\d*)\./
		if list[$1]
			list[$1] << img
		else
			list[$1] = [img]
		end
	end
	list
end

# update README file, or create one if nonexistent
File.open 'README.md', 'w' do |f|
	f.puts '# ' + TITLE
  f.puts ''
	f.puts File.read LEGAL_FILE # insert legal disclaimer
	f.puts ''
	f.puts '---'
	images.sort_by { |size, i| size.to_i }.reverse_each do |dimension, images|
		f.puts "## #{dimension} px"
		images.each do |path|
			title = path.scan(/(\w*)-/).flatten.map(&:capitalize).join(' ')
			f.puts "![#{title}](#{path})"
		end
		f.puts ''
	end
end

puts "Links were successfully generated for #{images.count} files:"
images.each { |filename| puts filename }
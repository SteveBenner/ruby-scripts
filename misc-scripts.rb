# Miscellaneous scripts

################################################################################
#  Recursively convert SASS files to alternate syntax
################################################################################
DIR = '/Users/rhomobile/github-xFactorApplications/companion-app/public/sass'
files = Dir.glob("#{DIR}/**/*.scss")
files.each { |f| `/Users/neo/.gem/ruby/2.1.0/bin/sass-convert #{f} #{f.sub(/\.scss/, '.sass')}` unless File.exist?(f.sub(/\.scss/, '.sass')) }
#files.each { |f| puts "/Users/neo/.gem/ruby/2.1.0/bin/sass-convert #{f} #{f.sub(/\.scss/, '.sass')}" unless File.exist?(f.sub(/\.scss/, '.sass')) }
#File.open('/tmp/convert.bash','w+') do |file|
#	file.puts "#!/bin/bash"
#	files.each { |f| file.puts "/Users/neo/.gem/ruby/2.1.0/bin/sass-convert #{f} #{f.sub(/\.scss/, '.sass')}" unless File.exist?(f.sub(/\.scss/, '.sass')) }
#end
#exec('/tmp/convert.bash')

# one-liner for CLI use
# ruby -e "Dir.glob('<project-root>/**/*.scss').each { |f| `sass-convert #{f} #{f.sub(/\.scss/, '.sass')}` unless File.exist?(f.sub(/\.scss/, '.sass')) }"
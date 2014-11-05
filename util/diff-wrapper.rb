#! /usr/bin/env ruby
#
# For a ton of information about this topic, see the stack overflow question below:
# - http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program
# The first 'article' referred to is now a dead link, and should be found here:
# - https://groups.google.com/d/msg/msysgit/qF-M5gdek1M/ueI-HtAxSJgJ
#
# Some relevant Git documentation:
#
# `git diff` uses the following environment variables:
#   <path> <old-file> <old-hex> <old-mode> <new-file> <new-hex> <new-mode>
#
# `git difftool` on the other hand, sets the following variables:
#   $LOCAL - current branch version of the file
#   $REMOTE - remote file version (to be merged)
#   $BASE - common ancestor file
#   $MERGED - file path where resulting file is written
#
# The signature for the JetBrains 'diff' executable is: <difftool-program> diff <file-1> <file-2>

# todo: take a look at this and see about updating this mess

DIFFTOOL = '/usr/local/bin/mine' # use RubyMine or any other JetBrains IDE with diff capability
ENV['PATH'].prepend "#{File.dirname(DIFFTOOL)}:" unless ENV['PATH'] =~ File.dirname(DIFFTOOL)

if File.exist? DIFFTOOL
	exec "#{DIFFTOOL} diff #{ENV['LOCAL']} #{ENV['REMOTE']}"
else
	abort "ERROR: Unable to locate difftool specified at #{DIFFTOOL}!"
end
#! /usr/bin/env ruby

DIFFTOOL = '/usr/local/bin/mine' # use RubyMine or any other JetBrains IDE with diff capability
ENV['PATH'].prepend "#{File.dirname(DIFFTOOL)}:" unless ENV['PATH'] =~ File.dirname(DIFFTOOL)

# links with some info:
# https://code.google.com/p/msysgit/issues/detail?id=106
# http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program

# `git diff` uses the following environment variables:
#   <path> <old-file> <old-hex> <old-mode> <new-file> <new-hex> <new-mode>
#
# `git difftool` on the other hand, sets the following variables:
#   $LOCAL - current branch version of the file
#   $REMOTE - remote file version (to be merged)
#   $BASE - common ancestor file
#   $MERGED - file path where resulting file is written
#
# JetBrains diff signature: <difftool-executable> diff <file-1> <file-2>

if File.exist? DIFFTOOL
	exec "#{DIFFTOOL} diff #{ENV['LOCAL']} #{ENV['REMOTE']}"
else
	abort "ERROR: Unable to locate difftool specified at #{DIFFTOOL}!"
end
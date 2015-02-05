# Helpful code for working with Git, GitHub, Gists, etc.
require 'pathname'
require 'shellwords'
require 'uri'

$cli_opts ||= {quiet: false}

# My local git repositories
REPO_DIRS = %w[~/github ~/bitbucket]
REPOS = REPO_DIRS.collect_concat do |dir|
  Pathname(dir).expand_path.children.select { |d| d.join('.git').directory? }
end

# Identifiers representing host URI's I use for git repositories
gh = {host: 'github.com', user: :SteveBenner}
bb = {host: 'bitbucket.org', user: :SteveBenner09}

module Git
  USER  = 'SteveBenner'
  GISTS = []

  class << self
    # Sets the remote tracking directory for the Git repo in given directory
    #
    # @param [String, Pathname] local_repo Directory containing a Git repository
    # @param [String, RemoteRepo, Symbol] remote The remote repository to assign to the local git repo
    #   remote repositories involved in the operation
    # todo: add an error tag here
    #
    def rset(local_repo, remote="/#{Pathname.pwd.basename}.git")
      # Set the remote repository name to that of the current directory as a default
      rem = RemoteRepo.new URI remote.to_s
      # rem.path =  if (remote.nil? || remote.is_a?(Symbol))
    end

    # Scans one or more directories for git repositories that have uncommitted changes, and reports them
    #
    # @param [Array<String, Pathname>] search_dirs Directories to search for git repositories in
    # @return [Array<Pathname>] A list of directories representing git repos with uncommitted changes
    #
    def dirty_repos(search_dirs=REPO_DIRS)
      puts "Scanning #{REPOS.count} git repos..." unless $cli_opts[:quiet]
      dirty = REPOS.select do |repo|
        Dir.chdir repo
        !`git diff`.empty?
      end
      puts(
        if dirty.count > 0 && !$cli_opts[:quiet]
          "Disgusting! #{dirty.count} dirty repo(s) were found!"
        else
          'All clean!'
        end
      )
      dirty
    end

    # Executes a Git commit in given directory with given message, for those times when you're in a mad hurry
    #
    # @param [String, Pathname] repo Directory containing a Git repository
    # @param [String] msg The commit message, which by default simply explains the ad-hoc nature of the commit
    #
    def quick_commit(repo, msg='WARNING: This commit was made automatically by a script, and should be reviewed!')
      log = File.open "#{Dir.home}/.logs/git.txt", 'a'
      Dir.chdir Pathname(repo).expand_path do |p|
        print "Performing quick commit for #{File.basename repo}... " unless $cli_opts[:quiet]
        log.puts `git add -A`
        log.puts `git commit -m "#{msg}"`
        log.puts
        result =  `git push origin`
        log.puts result
        puts result.empty? ? 'Done.' : 'Failed!'
      end
    end

    # @param [String] id The GitHub ID of a Gist within my personal collection
    # @return [String] if a Gist is found whose id matches the one supplied,
    # @return [NilClass] if no matching Gist is found within the collection
    def gist_desc(id)
      if GISTS.empty?
        require 'bundler'
        Bundler.setup :api
        require 'github_api'
        GISTS.replace Github.new.gists.list user: USER
      end
      gist = GISTS.find { |g| g['id'] == id }
      gist['description'].strip unless gist['description'].nil? # return a nice, clean string
    end
  end
end

# The following code is for renaming Gist directories using their Gist description instead of id
# NOTE: while attempting to rename folders, I encountered the error "Errno::ENOTEMPTY: Directory not empty"
# which I discovered to be a result of the file handler being unavailable, a very obscure problem.
# There is a discussion about the issue here: https://github.com/isaacs/rimraf/issues/25
# Needless to say, there is no solution right now, and the best ideas is to just restart the script.
# gist_ids = Git::GISTS.collect { |g| g['id'] }
# Pathname('~/gists').expand_path.children.select { |dir| gist_ids.include? dir.basename.to_s }
#   .each do |gist_dir|
#     newpath = gist_dir.dirname + Git.gist_desc(gist_dir.basename.to_s)
#     # handle empty descriptions by naming them 'untitled' with an incrementing number suffixed
#     if newpath.to_s == gist_dir.dirname.to_s
#       duplicate_number = gist_dir.dirname.children(true).select { |c| c.to_s =~ /^untitled/ }.count
#       newpath = "#{newpath}/untitled-#{duplicate_number}"
#     end
#     gist_dir.rename newpath
#     puts "#{gist_dir} was renamed to #{newpath}"
#   end
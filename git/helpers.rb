# Helpful code for working with Git, GitHub, Gists, etc.
require 'pathname'
require 'shellwords'
require 'uri'

$cli_opts ||= {quiet: false}

# My local git repositories
REPO_DIRS = %w[~/github ~/github/forks ~/bitbucket]
REPOS = REPO_DIRS.collect_concat do |dir|
  Pathname(dir).expand_path.children.select { |d| d.join('.git').directory? }
end

# Identifiers representing host URI's I use for git repositories
gh = {host: 'github.com', user: :SteveBenner}
bb = {host: 'bitbucket.org', user: :SteveBenner09}

class Pathname
  def git_repo?
    self.directory? && self.children(false).map(&:to_s).include?('.git')
  end
end

module Git
  USER  = 'SteveBenner'
  GISTS = []
  LOCAL_REPOS = {
    github: (Pathname('~/github').expand_path.children + Pathname('~/github/forks').expand_path.children)
      .select(&:git_repo?)
  }

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

    # Populates the GIST array with Gist data from the GitHub API
    def load_gists(user = USER)
      require 'bundler'
      Bundler.setup :api
      require 'github_api'
      GISTS.replace Github.new.gists.list user: user
    end

    # @param [String] id The GitHub ID of a Gist within my personal collection
    # @return [String] if a Gist is found whose id matches the one supplied,
    # @return [NilClass] if no matching Gist is found within the collection
    def gist_desc(id)
      load_gists if GISTS.empty?
      gist = GISTS.find { |g| g['id'] == id }
      gist['description'].strip unless gist['description'].nil? # return a nice, clean string
    end

	  # @param [String] The GitHub ID of a Gist within my personal collection
	  # @return [Integer] number of Stars the Gist has
		def gist_stars(id)
			require 'open-uri' unless defined? OpenURI
			require 'nokogiri' unless defined? Nokogiri
			html = open("https://gist.github.com/#{USER}/#{id}").read
			Nokogiri::XML(html).css('a[aria-label="Stars"] .counter').text.to_i
		end
  end
end

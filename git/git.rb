# Git helpers
require 'pathname'
require 'shellwords'
require 'uri'

$cli_opts ||= {quiet: false}

# todo: extract the below class code into a library
class GitRepo
	attr_accessor :uri

	def initialize(uri)
		@uri = URI uri
	end
end
class RemoteRepo < GitRepo
	attr_reader :type

	def initialize(uri)
		super(uri)
		@type = :remote
	end
end

# todo: integrate with or improve using 'grit' gem
REPO_DIRS = %w[~/github ~/bitbucket]
REPOS = REPO_DIRS.collect_concat do |repo_dir|
	Pathname(repo_dir).expand_path.children.select { |d| d.join('.git').directory? }
end
module Git
	# Identifier representing host URI's I use for git repositories
	GIT_HOSTS = {
	gh: 'github.com:SteveBenner', bb: 'bitbucket.org:SteveBenner09'
	}

	# Folders containing my git repositories

	# Sets the remote tracking directory for the Git repo in given directory
	#
	# @param [String, Pathname] local_repo Directory containing a Git repository
	# @param [String, RemoteRepo, Symbol] remote The remote repository to assign to the local git repo
	#   When a Symbol is given instead of the URI of a repo or repo object, it matches with list of
	#   git host identifiers stored in the {Git} module and creates a RemoteRepo with respective host.
	# @return [[LocalRepo, RemoteRepo]] If successful, returns {GitRepo} objects for the local and
	#   remote repositories involved in the operation
	# todo: add an error tag here
	#
	def rset(local_repo, remote="/#{Pathname.pwd.basename}.git")
		# Set the remote repository name to that of the current directory as a default
		rem = RemoteRepo.new URI remote.to_s
		# rem.path =  if (remote.nil? || remote.is_a?(Symbol))
	end

	# Lists all git repositories in given list of directories that have uncommitted changes
	#
	# @param [Array<String, Pathname>] search_dirs Directories to search for git repositories in
	# @return [Array<Pathname>] A list of directories representing git repos with uncommitted changes
	#
	def dirty_repos(search_dirs=::GIT_REPO_DIRS)
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
			end)
		dirty
	end

	# Executes a Git commit in given directory with given message, for those times when you're in a mad hurry
	#
	# @param [String, Pathname] repo Directory containing a Git repository
	# @param [String] msg The commit message, which by default simply explains the ad-hoc nature of the commit
	#
	def quick_commit(repo, msg='QUICK COMMIT! This was done automatically by a script, and should be reviewed.')
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
end


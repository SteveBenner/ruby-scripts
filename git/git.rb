# Git helpers
require 'pathname'
require 'shellwords'

$cli_opts ||= {quiet: false}

# todo: integrate with or improve using 'grit' gem
module Git
	# Folders containing my git repositories
	REPO_DIRS = %w[~/github ~/bitbucket]
	REPOS = GIT_REPO_DIRS.collect_concat do |repo_dir|

	end

	def dirty_repos(search_dirs=GIT_REPO_DIRS)
		repos = search_dirs.collect_concat do |dir|
			Pathname(dir).expand_path.children.select { |d| d.join('.git').directory? }
		end
		puts "Scanning #{repos.count} git repos..." unless $cli_opts[:quiet]
		dirty = repos.select do |repo|
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


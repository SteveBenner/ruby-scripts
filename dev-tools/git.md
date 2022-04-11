# Using Ruby to work with Git
Git is complex, laborious, and **insanely powerful**. Here is some Ruby code I wrote to do Git stuff.

**Note:** *the following Ruby code relies on file [`git.rb`][3] being loaded.*

### Renaming locally-downloaded Gist directories
If you clone a Gist, the resulting directory is named after the Gist's ID. Ew. Just ew.

So I grabbed the Gist data for my user via [the official API][1] and stored it in `Gist::GISTS`, then ran the code below, which successfully renamed most of the directories. It ended up failing partway through, spitting out `Errno::ENOTEMPTY: Directory not empty` which I later discovered to be a result of the file handler being unavailable, a very obscure problem, real low-level shit. [More discussion about this error can be found here](https://github.com/isaacs/rimraf/issues/25).

```ruby
gist_ids = Git::GISTS.collect { |g| g['id'] }
# Aggregate local Gist directories that are named with the ID of a gist in my collection
Pathname('~/gists').expand_path.children.select { |dir| gist_ids.include? dir.basename.to_s }
  .each do |gist_dir|
    # rename to the Gist description
    newpath = gist_dir.dirname + Git.gist_desc(gist_dir.basename.to_s)
    # handle empty descriptions by naming them 'untitled' with incrementing suffix
    if newpath.to_s == gist_dir.dirname.to_s
      duplicate_number = gist_dir.dirname.children(false).select { |c| c.to_s =~ /^untitled/ }.count
      newpath = "#{newpath}/untitled-#{duplicate_number}"
    end
    gist_dir.rename newpath
    puts "#{gist_dir} was renamed to #{newpath}"
  end
```

### Re-Initializing a bunch of Git repos after setting new template dir
After [setting up a custom Git templates folder][2], I have this problem where all my repos need to be re-initialized in order to copy over new hooks and stuff. I found out that simply running `git init` inside each repo directory wasn't enough to accomplish this... You see, unless you've been working with abnormal Git defaults, any repos you've initialized already contain a stock `hooks/` folder crammed with useless example scripts. ***EW***. The `hooks/` folder in my new template dir (which is actually a symlink) conflicts with this existing one, and so was not copied when I ran `git init`. Maybe it would be nice for Git to inform you of this (it does not). My solution is to delete that shit manually:

```ruby
# Iterate through Git repo directories, removing old `hooks` folders and re-initializing
LOCAL_REPOS[:github].each do |dir_path|
  hooks_dir = dir_path + '.git/hooks'
  hooks_dir.rmtree if hooks_dir.directory? && !(hooks_dir.symlink?)
  `git init`
end
```
---
**TODO:** Build YARD docs

[1]: https://developer.github.com/v3/gists/
[2]: https://github.com/SteveBenner/git-hooks#configuration
[3]: git.rb
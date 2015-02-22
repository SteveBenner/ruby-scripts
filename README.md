# Ruby Scripts
The contents of this repo are are mostly executable CLI scripts, with a few `pry`/`irb` helpers and other Ruby creations thrown in as well. They were created using **MRI `2.0+`** within **Mac OS X 10.9**. While they can be assumed functional unless otherwise stated, take into consideration that none have been tested in alternative environments, and most lack formal testing entirely. **Use at your own risk!**

### [Git](git/)
- `helpers` Adds module `Git` which contains various tools for repo management and misc. Git operations ***@TODO: Build YARD documentation for git helpers***

### [Utilities](utils/)
Various scripts I wrote to make my life easier, or just for fun/experimentation.

- `backup` Simple program to copy one or more given files into specified directory, defaults to `~/.backup/`
- `diff-wrapper` Used to launch a visual `diff` tool (RubyMine in this case) for viewing `git diff` output [^git-diff-so-thread]
- ~~~`sass-convert-dir`~~~ **This is fairly useless** *(now obsoleted by builtin SASS feature)*
- `shortcuttr` Lazy way to make an executable script from a single text string via CLI
- `split` Wraps the system tool for splitting files, offering more features and utility

### [Fun](fun/)
- `lolping` Tests the latency of several Riot servers, printing average ping recorded over given time period

### [Experimental](experiment/)
- `.slimrc` This is nothing more than an idea I had for a Slim 'rc' file, and it's not finished yet


## Submodules
Most of my Ruby code exists within projects that have repos of their own. View their original sources:


### [Mac Fixes](https://github.com/SteveBenner/mac-osx-fixes)
Run-once Ruby solutions to common problems plaguing Mac OS X
### [Git Hooks](https://github.com/SteveBenner/git-hooks)

---
**DISCLAIMER**: Files in this repository may contain code taken from online sources for which I claim neither ownership nor authorship. I will do my best to attribute credit where due, and to supply and adhere to any relevant licenses for such code. If detected, please report improper licensing or usage of any material within this repository by creating an issue.

[1]: https://bitbucket.org/SteveBenner09/sb-git

[^git-diff-so-thread]: See [this Stack Overflow thread](http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program/) for more info about using external `diff` tools with git.
# Ruby Scripts
Designed and tested in **Mac OS X 10.9.5**

### [Git](git/)
- `helpers` Adds module `Git` which contains various tools for repo management and misc. Git operations ***@TODO: Build YARD documentation for git helpers***

### [Utilities](utils/)
Various scripts I wrote to make my life easier, or just for fun/experimentation.

- `diff-wrapper` Used to launch a visual `diff` tool (RubyMine in this case) for viewing `git diff` output [^git-diff-so-thread]
- ~~~`sass-convert-dir`~~~ **This is fairly useless** *(I wrote it before I knew about the builtin `sass-convert -R` command)*
- `shortcuttr` Lazy way to make an executable script from a single text string via CLI

### [Fun](fun/)
- `lolping` Tests the latency of several Riot servers, printing average ping recorded over given time period

### [Experimental](experiment/)
- `.slimrc` This is nothing more than an idea I had for a Slim 'rc' file, and it's not finished yet


## Submodules
Most of my Ruby code exists within projects that have repos of their own. View their original sources:


### [Mac Fixes](https://github.com/SteveBenner/mac-osx-fixes)
Run-once Ruby solutions to common problems plaguing Mac OS X
### [Git Hooks](https://github.com/SteveBenner/git-hooks)


### [Homebrew](homebrew/)
utilities and fixes for [the amazing Mac package manager](http://brew.sh/)

---
**DISCLAIMER**: There may be scripts contained in this repository that contain code taken from online sources, for which I claim neither ownership nor authorship. I will do my best to attribute credit to the original authors and provide software licenses where pertinent. I provide and utilize these scripts with the understanding that in doing so, I am not violating any law. If there is any copyright or licensing information missing from this repository which should be included, please contact me ASAP or submit a pull request, so the situation may be-corrected.

[1]: https://bitbucket.org/SteveBenner09/sb-git

[^git-diff-so-thread]: See [this Stack Overflow thread](http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program/) for more info about using external `diff` tools with git.
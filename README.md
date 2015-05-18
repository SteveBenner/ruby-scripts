# Ruby Scripts
This is where I keep all my standalone Ruby creations such as executable CLI tools, modules for use in `rib` / `pry` console, useful snippets, and more.

Scripts are created using **MRI `2.0+`** (unless otherwise indicated) on **Mac OS X 10.9**.

**DISCLAIMER:** Files in this repository may contain code taken from online sources for which I claim neither ownership nor authorship. I will do my best to attribute credit where due, and to supply and adhere to any relevant licenses for such code. If detected, please report improper licensing or usage of any material within this repository via Github issue.

---

### [Developer Tools](dev-tools/)
Things that make it easier to develop software and work with source code.

- `git` Adds module `Git` which contains helpers for repo management and Git operations

  [Examples of using Ruby to work with Git][2] (annotated code)
- `diff-wrapper` Used to launch a visual `diff` tool (RubyMine in this case) for viewing `git diff` output [^git-diff-so-thread]
- ~~~`sass-convert-dir`~~~ **This is fairly useless** *(now obsoleted by builtin SASS feature)*

### [System Utilities](system-utils/)
Scripts for performing various useful operations in Unix systems.

- `backup` Simple program to copy one or more given files into specified directory
- `shortcuttr` Lazy way to make an executable script from a single text string via CLI
- `split` Wraps the system tool for splitting files, offering more features and utility

### [Fun](fun/)
- `lolping` Tests the latency of several Riot servers, printing average ping recorded over given time period

### [Experimental](experiment/)
- `.slimrc` This is nothing more than an idea I had for a Slim 'rc' file, and it's not finished yet

## Submodules
Additional scripts are kept in separate repos, and included via Git submodule:

- ### [Mac Fixes](https://github.com/SteveBenner/mac-osx-fixes)

  Run-once Ruby solutions to common problems plaguing Mac OS X
  
- ### [Git Hooks](https://github.com/SteveBenner/git-hooks)


[1]: https://bitbucket.org/SteveBenner09/sb-git
[2]: dev-tools/git.md

[^git-diff-so-thread]: See [this Stack Overflow thread](http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program/) for more info about using external `diff` tools with git.

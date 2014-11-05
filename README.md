# Ruby Scripts
These are Ruby scripts I've either authored or modified.

Note: Scripts are designed and tested for use in **OS X 10.9 Mavericks** using my unique environment and tools; their functionality is not guaranteed in other systems.

---
### [Fun](fun/)
- `lolping` Tests the latency of several Riot servers and prints out the average ping for given time period

### [Git](git/)
- `git-hooks/` Collection of useful scripts for hardcore Git users (you know what to do with these!)
- `helpers` Assorted tools for managing git repositories and operations ***@TODO: Build YARD documentation for git helpers***

    **NOTE:** The scripts in `/helpers` depend on my personal `Git` ruby library (which can be found [here][1])

### [Git hooks](git-hooks/)
Scripts I've made to execute on git events to automate certain tasks.

### [Util](util/)
Various scripts I wrote to make my life easier, or just for fun/experimentation.

- `diff-wrapper` Used to launch a visual `diff` tool (RubyMine in this case) for viewing `git diff` output [^git-diff-so-thread]
- ~~~`sass-convert-dir`~~~ **This is fairly useless** *(I wrote it before I knew about the builtin `sass-convert -R` command)*
- `shortcuttr` Lazy way to make an executable script from a single text string via CLI

## Submodules
If you're in need of a fix, try browsing my library of custom solutions from the following separately-maintained repositories:

### [Mac OS X fixes](https://github.com/SteveBenner/mac-osx-fixes): run-once Ruby solutions for common problems plaguing Mac OS X.  
### [Homebrew](homebrew/): utilities and fixes for [the amazing Mac package manager](http://brew.sh/)

---
**DISCLAIMER**: There may be scripts contained in this repository that contain code taken from online sources, for which I claim neither ownership nor authorship. I will do my best to attribute credit to the original authors and provide software licenses where pertinent. I provide and utilize these scripts with the understanding that in doing so, I am not violating any law. If there is any copyright or licensing information missing from this repository which should be included, please contact me ASAP or submit a pull request, so the situation may be corrected.

[1]: https://bitbucket.org/SteveBenner09/sb-git

[^git-diff-so-thread]: See [this Stack Overflow thread](http://stackoverflow.com/questions/255202/how-do-i-view-git-diff-output-with-a-visual-diff-program/) for more info about using external `diff` tools with git.
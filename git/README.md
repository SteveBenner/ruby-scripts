# Scripts for Git
As one of my most-often used tools and extremely complex, Git will undeniably remain a major focus of my scripting far into the future.

# Library
I intend to use the `grit` gem fairly soon, and/or incorporate it into my own library, but for now I rely on some stuff I wrote from scratch...

# Hooks

## Pre-Commit

- **generate-img-previews**

    This script generates a Markdown README file with links to all the images in the same folder with a special file name suffix, so your boring old GitHub README turns into a spiffy image gallery.
    
## Post-Commit

- **convert-tabs-to-spaces**

    ~~This hook runs on all files that were modified in a commit, converting `\t` tabs within to spaces using Ruby. A `Hash` in the script specifies the tab width for each language.~~ **THIS IS CURRENTLY BROKEN!**
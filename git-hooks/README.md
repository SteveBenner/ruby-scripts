# Git Hooks

## Pre-Commit

- **generate-img-previews**

    This script generates a Markdown README file with links to all the images in the same folder with a special file name suffix, so your boring old GitHub README turns into a spiffy image gallery.
    
## Post-Commit

- **convert-tabs-to-spaces**

    ~~This hook runs on all files that were modified in a commit, converting `\t` tabs within to spaces using Ruby. A `Hash` in the script specifies the tab width for each language.~~ **THIS IS CURRENTLY BROKEN!**
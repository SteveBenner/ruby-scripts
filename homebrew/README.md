# Homebrew scripts
I made some things for Homebrew, and they make it even MORE awesome! 

## Fixes
Single-serving problem solvers you can run as an executable.

1. **osxfuse**

    Some software, such as Bitcasa and TrueCrypt, install libs that don't brew nicely with others.

## Unbrew
A simple Homebrew uninstaller script with the following features:

- Safely deletes all files installed by [Homebrew]
- Outputs list of deleted files, as well as listing formulae and kegs that were removed
- Can locate and return the path where Homebrew is installed on your machine
- Code for locating Homebrew path is easily extendable with custom logic
- Standard CLI functionality via modes: **quiet**, **verbose**, **force**, **dry-run**

### TODO:
- remove symlinks (see downloaded copy of gist fork)

#### Changelog
**0.1.2**

- Script now prints a list of all formulae and kegs that were removed during uninstallation

**0.1.1**

- Added versioning for the script, and an option to display it


[my gists]:https://gist.github.com/SteveBenner
[Homebrew]:https://github.com/Homebrew/homebrew
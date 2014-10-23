Chaim-Leib's dotfiles
=====================
This repo contains my personal configuration files and tools.

The Mac-specific code is the most fleshed-out, since this is my main system. My
goal was to be able to start with a clean system, run `install_mac.sh`, and end
up with an almost fully-configured system.

Features
--------
* Comes with installers to symlink the files into place automatically
* `mac/installers` - installers for many programs, both CLI and GUI
* `.bashrc.d/*lssys.sh` - list the system info, including OS, CPU and RAM
* `local/darwin-x86_64/provide/bin/ppl` - pretty-print an alphabetized plist.
    Useful for `git diff`

Hacking
-------
### Structure
#### `bashrc`
* The main bashrc is symlinked to `~/.bashrc` from `dotfiles`.

* `.profile` just sources `~/.bashrc`

* `.bashrc` sources all scripts in `~/.bashrc.d` that have their execute permission set.

#### `bashrc.d`
* `~/.bashrc.d` is also symlinked from `dotfiles`. Only files with execute permissions are sourced.
* Inside `.bashrc.d`, all scripts are given a numerical prefix to control their order. Some scripts, like `*-paths.sh`, depend on earlier scripts, like `*-pathfuncs`.

* Some of the scripts in `.bashrc.d` define new commands as bash functions and aliases. Others set environment variables.

#### `bash_completion`
* There is a bash_completion file symlinked to `~/.bash_completion` from `dotfiles`.

* There is also a folder for bash_completion symlinked to `~/.bash_completion.d` from `dotfiles`.

#### Other rc's
* `.hushlogin` is an empty file. Tells some system-level rc's to silence their output.
* Vim: `.vimrc`, `.vim`
* BC: 
    * `.ee.bcrc` for electrical engineering. Used when we run `eebc`
    * `.phy.bcrc` for physics. Used when we run `pbc`
* Git:
    * `.gitconfig` contains my name and email. **You should change this!**
    * `common/home/.gitconfig` for versions of git < 2.0
    * `cygwin/home/.gitconfig` for versions of git < 2.0 (extra?)
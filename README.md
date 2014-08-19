Chaim-Leib's dotfiles
=====================
This repo contains my personal configuration files and tools.

The Mac-specific code is the most fleshed-out, since this is my main system. My
goal was to be able to start with a clean system, run `install_mac.sh`, and end
up with an almost fully-configured system.

Features
--------
* `mac/installers` - installers for many programs, both CLI and GUI
* `.bashrc.d/*lssys.sh` - list the system info, including OS, CPU and RAM
* `local/darwin13-x86_64/provide/bin/ppl` - pretty-print an alphabetized plist.
    Useful for `git diff`

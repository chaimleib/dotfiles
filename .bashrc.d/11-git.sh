#!/bin/bash

alias modg='vim ~/.bashrc.d/*-git.sh'

# Non-modifying commands
alias gis='git status'
alias gil='git log'
alias gid='git diff HEAD'
alias gids='git diff HEAD --staged'

# Branches
alias gib='git branch'
alias gic='git checkout'
alias gitcb="git branch | grep ^\* | cut -d' ' -f2-"

alias gir='git rebase'
alias gim='git merge'
alias gif='git fetch --all'


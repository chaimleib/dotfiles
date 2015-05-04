#!/bin/bash

alias modg='vim ~/.bashrc.d/*-git.sh'

# use hub instead of git to easily work with github
if have hub; then
    alias git='hub'
fi

# Non-modifying commands
alias gis='git status -sb'
alias gil='git log'
alias gid='git diff HEAD --word-diff'
alias gids='git diff HEAD --word-diff --staged'
alias gidl='gid HEAD^1'

# Branches
alias gib='git branch'
alias gic='git checkout'
alias gitcb="git branch | grep ^\* | cut -d' ' -f2-"

alias gir='git rebase'
alias gim='git merge'
alias gif='git fetch --all'


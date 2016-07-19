#!/bin/bash

alias modg='vim ~/.bashrc.d/*-git.sh'
alias modc='git config --edit'

# use hub instead of git to easily work with github
if have hub; then
    alias git='hub'
fi

# Non-modifying commands
alias gis='git status -sb'
alias gil='git log --date=local --pretty=format:"%C(bold blue)%h %C(green)%an %C(yellow)%ad%x08%x08%x08%x08%x08%x08%x08%x08%C(reset) : %s"'
alias gid='git diff HEAD'
alias gids='git diff HEAD --staged'
alias gidw='git diff HEAD --word-diff'
alias gidsw='git diff HEAD --word-diff --staged'
alias gidl='gid HEAD^1'

# Branches
alias gib='git branch'
alias gic='git checkout'
alias gitcb="git branch | grep ^\* | cut -d' ' -f2-"

alias gir='git rebase'
alias gim='git merge'
alias gif='git fetch --all'

function cdr() {
    cd "$(git rev-parse --show-toplevel)/$1"
}

function gitpath() {
    git rev-parse --show-toplevel
}

#!/bin/bash

if have rbenv; then
  eval "$(rbenv init -)"
fi

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
fi

# Rails
alias rp='bundle exec rails runner "puts Rails.root"'
function rr() {
    fp="$(relpath "$1" "$(rp)")"
    bundle exec rails runner "eval(File.read '$fp')"
}

# export USING_CAPYBARA=true


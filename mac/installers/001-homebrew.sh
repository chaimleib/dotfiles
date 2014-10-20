#!/bin/bash

printf "%-30s" "Installing brew..."
if brew --version 1>/dev/null 2>/dev/null; then
    version="$(brew --version | grep -o '[0-9]\+\.[0-9\.]\+')"
    echo "Already installed $version"
else
    ruby -e "$(curl -fsSL https://raw.githusercontent.com/Homebrew/install/master/install)"
    if brew doctor; then
        brew update
        brew upgrade
    fi
    version="$(brew --version | grep -o '[0-9]\+\.[0-9\.]\+')"
    echo "Installed $version"
fi

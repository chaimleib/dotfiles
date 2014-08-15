#!/bin/bash

printf "%-30s" "Installing wget..."
if [[ "$(which wget)" == "/usr/local/bin/wget" ]]; then
    version="$(wget --version 2>&1 | grep -o '[0-9]\+\.[0-9\.]\+' | head -n1)"
    echo "Already installed $version"
else
    brew install wget
    version="$(wget --version 2>&1 | grep -o '[0-9]\+\.[0-9\.]\+' | head -n1)"
    echo "Installed $version"
fi


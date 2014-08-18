#!/bin/bash

printf "%-30s" "Installing Python 2..."
if [[ "$(which python)" == "/usr/local/bin/python" ]]; then
    version="$(python --version 2>&1 | grep -o '[0-9]\+\.[0-9\.]\+')"
    echo "Already installed $version"
else
    brew install python
    version="$(python --version 2>&1 | grep -o '[0-9]\+\.[0-9\.]\+')"
    echo "Installed $version"
fi


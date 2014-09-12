#!/bin/bash

pkgName="fswatch"
cmdName="$pkgName"

function getInstalledVersion() {
    version="$("$cmdName" --version 2>&1 | grep -o '[0-9]\+\.[0-9\.]\+' | head -n1)"
    echo "$version"
}

printf "%-30s" "Installing $pkgName..."
if [[ "$(which "$cmdName")" == "/usr/local/bin/$cmdName" ]]; then
    version="$(getInstalledVersion)"
    echo "Already installed $version"
else
    errors="$(brew install "$pkgName")"
    if [[ $? != 0 ]]; then
        echo "$errors"
        return 1
    fi
    
    version="$(getInstalledVersion)"
    echo "Installed $version"
fi


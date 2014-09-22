#!/bin/bash

pkgName="imagemagick"
cmdName=convert

function getInstalledVersion() {
    version="$(
        $cmdName --version | 
        grep -o '[0-9]\+\.[0-9\.]\+' | 
        head -n1
    )"
    echo "$version"
}

printf "%-30s" "Installing $pkgName..."
version="$(getInstalledVersion 2>/dev/null)"
if [[ -n "$version" ]]; then
    echo "Already installed $version"
else
    errors="$(brew install "$pkgName" 2>&1)"
    if [[ $? != 0 ]]; then
        echo "$errors"
        return 1
    fi
    
    version="$(getInstalledVersion)"
    echo "Installed $version"
fi


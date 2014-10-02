#!/bin/bash

pkgName="watch"
cmdName="$pkgName"

function getInstalledVersion() {
    version="$(
        $cmdName --version 2>&1 | 
        grep -o '[0-9]\+\.[0-9\.]\+[0-9]' | 
        head -n1
    )"
    [[ -n "$version" ]] && echo "$version" || echo "none"
}

printf "%-30s" "Installing $pkgName..."
version="$(getInstalledVersion)"

if [[ "$version" != "none" ]]; then
    echo "Already installed $version"
else
    echo "Installing..."
    errors="$(brew install "$pkgName" 2>&1)"
    if [[ $? != 0 ]]; then
        echo "$errors"
        exit 1
    fi
    
    version="$(getInstalledVersion)"
    echo "Installed $version"
fi


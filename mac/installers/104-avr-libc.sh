#!/bin/bash

pkgName="avr-libc"
cmdName=avr-gcc

function getLatestVersion() {
    version="$(brew info "$pkgName" 2>/dev/null |
        grep -o '[0-9]\+\.[0-9\.]\+' |
        head -n1
    )"
    echo "$version"
}

function getInstalledVersion() {
    version="$(ls  /usr/local/Cellar/"$pkgName" |
        sort -r |
        head -n1
    )"
    if [[ -z "$version" ]]; then
        echo none
        return
    fi
    echo "$version"
}

printf "%-30s" "Installing $pkgName..."
version="$(getInstalledVersion 2>/dev/null)"
if [[ -n "$version" ]] && [[ "$version" != 'none' ]]; then
    echo "Already installed $version"
else
    errors="$(brew tap larsimmisch/avr 2>&1)"
    if [[ $? != 0 ]]; then
        echo "$errors"
        return 1
    fi
    errors="$(brew install "$pkgName" 2>&1)"
    if [[ $? != 0 ]]; then
        echo "$errors"
        return 1
    fi

    version="$(getInstalledVersion)"
    echo "Installed $version"
fi


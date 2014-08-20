#!/bin/bash

name="iTerm"

this_dir="$(dirname "$0")"
osVer="$("$this_dir"/utils/osVersion.sh)"

if [[ "$osVer" > "10.7" ]]; then
    uri="https://iterm2.com/downloads/stable/iTerm2_v2_0.zip"
elif [[ "$osVer" > "10.5" ]]; then
    uri="https://iterm2.com/downloads/stable/iTerm2_v2_0-LeopardPPC.zip"
else
    echo "ERROR: This version of Mac OS X ($osVer) is too old for $name"
    exit 1
fi
plistPath="/Applications/$name.app/Contents/Info.plist"

function main() {
    printf "%-30s" "Installing $name..."
    
    version="$(getInstalledVersion)"
    
    if [[ -d "/Applications/$name.app" ]]; then
        echo "Already installed $version"
        return
    fi
    
    echo
    echo "$version is installed. Installing..."
    
    zipPath="/tmp/Install ${name}.zip"
    if ! downloadInstaller "$zipPath"; then
        echo "ERROR: Failed to download. Result was `cat "$zipPath"`"
        return 1
    fi
    if ! installZip "$zipPath"; then
        echo "ERROR: Failed to install"
        return 1
    fi
    
    rm "$zipPath"
    
    if [[ "$installed" != "none" ]]; then
        echo "Installed"
        return 0
    else
        return 1
    fi
}

function downloadInstaller() {
    zipPath="$1"
    
    if [[ ! -n "$zipPath" ]]; then
        echo "Must specify destination path for installer zip!"
        return 1
    fi
    
    curl "$uri" -o "$zipPath"
    if [[ "$?" != '0' ]]; then
        return $?
    fi
    if file "$zipPath" | grep 'Zip archive' 2>/dev/null >/dev/null; then
        return 0
    else
        return 1
    fi
}

function installZip() {
    zipPath="$1"
    echo "Unzipping to /Applications..."
    pushd "/Applications" 2>/dev/null >/dev/null
    tar -xzf "$zipPath"
    popd 2>/dev/null >/dev/null
    
    if [[ -d "/Applications/$name.app" ]]; then
        return
    else
        return 1
    fi
}

function getInstalledVersion() {
    infoPath='/Applications/iTerm.app/Contents/Info.plist'
    if [[ ! -e "$infoPath" ]]; then
        echo 'none'
        return
    fi
    version="$(plutil -convert xml1 "$infoPath" -o - | 
        grep '<key>CFBundleVersion</key>' -A1 |
        grep -o '[0-9]\+\.[0-9\.]*[0-9]'
    )"
    echo "$version"
}

main

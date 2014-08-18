#!/bin/bash


function main() {
    printf "%-30s" "Installing Google Chrome..."
    
    installed="$(getInstalledVersionNum)"
    latest="$(getLatestVersionNum)"
    if [[ "$installed" == "$latest" ]]; then
        echo "Already installed $installed"
        return
    fi
    
    echo
    echo "$installed is installed. Installing $latest..."
    
    dmgPath="/tmp/googlechrome.dmg"
    if ! downloadInstaller "$dmgPath"; then
        echo "ERROR: Failed to download. Result was `cat "$dmgPath"`"
        return 1
    fi
    if ! installDmg "$dmgPath"; then
        echo "ERROR: Failed to install."
        return 1
    fi
    
    rm "$dmgPath"
    
    installed="$(getInstalledVersionNum)"
    if [[ "$latest" == "$installed" ]]; then
        echo "Installed $installed"
        return 0
    else
        echo "ERROR: Update unsuccessful, version remains at $installed"
        return 1
    fi
}

function downloadInstaller() {
    dmgPath="$1"
    
    if [[ ! -n "$dmgPath" ]]; then
        echo "Must specify destination path for installer dmg!"
        return 1
    fi
    
    uri="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
    curl "$uri" -o "$dmgPath"
    if [[ "$?" != '0' ]]; then
        return $?
    fi
}

function installDmg() {
    dmgPath="$1"
    echo "Mounting disk image..."
    hdiutil attach "$dmgPath" -nobrowse -quiet || return 1
    vol="$(
        df |
        grep -o '/Volumes/.*Google.*Chrome.*$' |
        tail -n1
    )"
    echo "Mounted at $vol"
    echo "Copying to /Applications..."
    cp -r "$vol/Google Chrome.app" /Applications/ || return 1
    echo "Unmounting..."
    umount "$vol" || return 1
    hdiutil detach $(df | grep "$vol" | awk '{print $1}') -quiet
    
    if [[ -d "/Applications/Google\ Chrome.app" ]]; then
        return
    else
        return 1
    fi
}
    
function getInstalledVersionNum() {
    plistPath="/Applications/Google Chrome.app/Contents/Info.plist"
    if [[ -f "$plistPath" ]]; then
        installedVer="$(defaults read "$plistPath" CFBundleShortVersionString)"
    else
        installedVer="none"
    fi
    echo "$installedVer"
}

function getLatestVersionNum() {
    latestVer="$(curl -s http://googlechromereleases.blogspot.com | 
        grep -i 'Stable Channel' | 
        grep Mac | 
        grep -o '[0-9]\+\.[0-9\.]\+'
    )"
    echo "$latestVer"
}

main

#!/bin/bash

name="Steam"
uri="http://media.steampowered.com/client/installer/steam.dmg"
plistPath="/Applications/$name.app/Contents/Info.plist"

function main() {
    printf "%-30s" "Installing $name..."
    
    installed="$(getInstalledVersionNum)"
    if [[ "$installed" != "none" ]]; then
        echo "Already installed $installed"
        return
    fi
    
    echo
    echo "$installed is installed. Installing..."
    
    dmgPath="/tmp/Install ${name}.dmg"
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
        grep -o '/Volumes/.*'$name'.*$' |
        tail -n1
    )"
    echo "Mounted at $vol"
    echo "Copying to /Applications..."
    cp -r "$vol/$name.app" /Applications/ || return 1
    echo "Unmounting..."
    umount "$vol" || return 1
    hdiutil detach $(df | grep "$vol" | awk '{print $1}') -quiet
    
    if [[ -d "/Applications/$name.app" ]]; then
        return
    else
        return 1
    fi
}
    
function getInstalledVersionNum() {
    if [[ -f "$plistPath" ]]; then
        installedVer="$(defaults read "$plistPath" CFBundleVersion)"
    else
        installedVer="none"
    fi
    echo "$installedVer"
}


main

#!/bin/bash

name="PyCharm"
function getDmgUri() {
    curl -s \
            --data "os=mac&edition=comm" \
            http://www.jetbrains.com/pycharm/download/download_thanks.jsp | 
        grep -o "http:.*\.dmg" | 
        head -n1
}
uri="$(getDmgUri)"
latest="$(echo "$uri" | grep -o '[0-9]\+\.[0-9\.]*[0-9]')"

function main() {
    printf "%-30s" "Installing $name..."
    
    installed="$(getInstalledVersionNum)"
    if [[ "$installed" == "$latest" ]]; then
        echo "Already installed $installed"
        return
    fi
      
    echo
    echo "$installed is installed. Installing $latest..."
    
    dmgPath="/tmp/Install $name.dmg"
    if ! downloadInstaller "$dmgPath"; then
        echo "ERROR: Failed to download. Result was `cat "$dmgPath"`"
        return 1
    fi
    if ! installDmg "$dmgPath"; then
        echo "ERROR: Failed to install"
        return 1
    fi
    
    rm "$dmgPath"
    
    installed="$(getInstalledVersionNum)"
    if [[ "$latest" == "$installed" ]]; then
        echo "Installed $installed"
        return 0
    else
        echo "ERROR: Update to $latest unsuccessful, version remains at $installed"
        return 1
    fi
}


function getInstalledVersionNum() {
    # Get version of the installed flash version, if present
    infoPath="$(ls "/Applications/"*"$name"*".app/Contents/Info.plist")"
    if [[ -e "$infoPath" ]]; then
        installedVer="$(defaults read "$infoPath" CFBundleShortVersionString)"
    else
        installedVer="none"
    fi
    echo "$installedVer"
}

function getLatestVersionNum() {
    echo "$latest"
}

function downloadInstaller() {
    dmgPath="$1"
    
    if [[ ! -n "$dmgPath" ]]; then
        echo "Must specify destination path for installer dmg!"
        return 1
    fi
    
    echo "Downloading from $uri"
    curl --user-agent "$(utils/safariAgent.sh)" -L "$uri" -o "$dmgPath"
    
    if file "$dmgPath" | grep ': data$' 2>/dev/null 1>/dev/null; then
        return
    else
        return 1
    fi
}

function installDmg() {
    dmgPath="$1"
    if [[ ! -e "$dmgPath" ]]; then
        echo "ERROR: $dmgPath does not exist"
        return 1
    fi
    echo "Mounting disk image..."
    hdiutil attach "$dmgPath" -nobrowse -quiet
    vol="$(
        df |
        grep -o "/Volumes/.*$name.*$" |
        tail -n1
    )"
    if [[ -z "$vol" ]]; then
        echo "ERROR: Failed to mount"
        return 1
    fi
    echo "Mounted at $vol"
    
    app="$(ls -d "$vol"/*"$name"*.app)"
    cp -r "$app" /Applications/
    success="$?"
    printf "Waiting to unmount disk image"
    while ! umount "$vol" 2>/dev/null >/dev/null; do
        sleep 1
        printf "."
    done
    echo " Unmounted"
    hdiutil detach $(df | grep "$vol" | awk '{print $1}') -quiet
    return $success
}
    
    
main

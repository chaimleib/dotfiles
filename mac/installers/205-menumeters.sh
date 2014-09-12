#!/bin/bash

name="MenuMeters"
basepath='http://www.ragingmenace.com/software/menumeters'

function getDmgLink() {
    curl -sL "$basepath" | 
        grep  "href=\".*\.dmg" | 
        grep '[0-9]\+\.[0-9\.]*[0-9]' |
        head -n1
}

link="$(getDmgLink)"

uri="$(echo "$link" | grep -o '[^"]\+\.dmg')"
uri="$(resolve "$basepath" "$uri")"
latest="$(echo "$link" | grep -o '[0-9]\+\.[0-9\.]*[0-9]')"

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
    infopath="Library/PreferencePanes/${name}.prefPane/Contents/Info.plist"
    for basepath in ~ /; do
        resolved="$(resolve "$basepath" "$infopath")"
        if [[ -e "$resolved" ]]; then
            installedVer="$(defaults read "$resolved" CFBundleShortVersionString)"
            echo "$installedVer"
            return
        fi
    done
    echo 'none'
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
    
    if file "$dmgPath" | grep ': HTML document text$' 2>/dev/null 1>/dev/null; then
        return 1
    else
        return
    fi
}

function installDmg() {
    dmgPath="$1"
    if [[ ! -e "$dmgPath" ]]; then
        echo "ERROR: $dmgPath does not exist"
        return 1
    fi
    echo "Mounting disk image..."
    vol="$(hdiutil attach "$dmgPath" -nobrowse |
        grep Volumes |
        cut -f3
    )"
    if [[ -z "$vol" ]]; then
        echo "ERROR: Failed to mount"
        return 1
    fi
    echo "Mounted at $vol"
    
    app="$(ls -d "$vol"/*"$name"*.app)"
    #cp -r "$app" /Applications/
    open "$app"
    success="$?"
    printf "Waiting to unmount disk image"
    while ! hdiutil detach "$vol" 2>/dev/null >/dev/null; do
        sleep 1
        printf "."
    done
    echo " Unmounted"
    return $success
}
    
    
main

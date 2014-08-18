#!/bin/bash

function main() {
    printf "%-30s" "Installing Flash Player..."
    
    installed="$(getInstalledVersionNum)"
    latest="$(getLatestVersionNum)"
    if [[ "$installed" == "$latest" ]]; then
        echo "Already installed $installed"
        return
    fi
    
    echo
    echo "$installed is installed. Installing $latest..."
    
    dmgPath="/tmp/flash.dmg"
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

function getInstalledVersionNum() {
    # Get version of the installed flash version, if present
    pluginPath="/Library/Internet Plug-Ins/Flash Player.plugin"
    if [[ -e "$pluginPath" ]]; then
        installedVer="$(defaults read "$pluginPath"/Contents/version CFBundleShortVersionString)"
    else
        installedVer="none"
    fi
    echo "$installedVer"
}

function getLatestVersionNum() {
    # Get latest version number available from the internet
    latestVer="$(curl -s http://www.adobe.com/software/flash/about/ | 
        grep -A2 Mac |
        grep -A1 Safari | 
        tail -n1 | 
        grep -o '[0-9]\+\.[0-9\.]\+'
    )"
    echo "$latestVer"
}

function downloadInstaller() {
    dmgPath="$1"
    
    if [[ ! -n "$dmgPath" ]]; then
        echo "Must specify destination path for installer dmg!"
        return 1
    fi
    
    # Pretend to be Safari, or we will get an "unsupported browser" message
    agent="$(utils/safariAgent.sh)"
    
    echo "Loading download page"
    
    welcome="/tmp/flashWelcome.html"
    uri="http://get.adobe.com/flashplayer/"
    curl --user-agent "$agent" -s "$uri" -o "$welcome"

    buttonId="$(cat "$welcome" |
        grep '\(Install now\|Download\)$' -C1 | 
        grep -o 'id="[^"]\+"' | 
        grep -o '[a-zA-Z0-9_]\+' | 
        tail -n1)"

    buttonParams="$(cat "$welcome" |
    sed -n "/(\"#$buttonId\")\.downloadbutton/,/\}/p" |
    grep "^\s\+[a-zA-Z]"
    )"

    rm "$welcome"

    mainInstaller="$(
        echo "$buttonParams" |
        grep "mainInstaller:" |
        grep -o '[A-Za-z0-9_\.-]\+' |
        tail -n1
    )"

    uriParams="installer=$mainInstaller&os=OSX&browser_type=KHTML&browser_dist=Safari"
    uri="http://get.adobe.com/flashplayer/download/?$uriParams"

    echo "Loading redirect page"
    dmgUri="$(curl --user-agent "$agent" -s "$uri" |
        grep -o "http.*\.dmg" | 
        tail -n1
    )"

    echo "Downloading from $dmgUri"
    curl --user-agent "$agent" "$dmgUri" -o "$dmgPath"
    
    if file "$dmgPath" | grep bzip2 2>/dev/null 1>/dev/null; then
        return
    else
        return 1
    fi
}

function installDmg() {
    dmgPath="$1"
    echo "Mounting disk image..."
    hdiutil attach "$dmgPath" -nobrowse -quiet
    flashVol="$(
        df |
        grep -o '/Volumes/.*Flash Player.*$' |
        tail -n1
    )"
    echo "Mounted at $flashVol"
    
    echo "Running installer..."
    pkgPath="$(ls -d "$flashVol"/Install*Flash*.app)"
    echo "$pkgPath"
    open -W -a "$pkgPath" 
    success=$?
    sleep 10
    printf "Waiting to unmount disk image"
    while ! umount "$flashVol" 2>/dev/null >/dev/null; do
        sleep 1
        printf "."
    done
    echo " Unmounted"
    hdiutil detach $(df | grep "$flashVol" | awk '{print $1}') -quiet
    return $success
}
    
    
main

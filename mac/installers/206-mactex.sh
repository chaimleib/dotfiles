#!/bin/bash
name="MacTeX"
basepath='https://tug.org/mactex/'

landingPage="$(curl -sL "$basepath")"

function getInstallerUri() {
    echo "$landingPage" | 
        grep  "href=\".*\.pkg" | 
        head -n1 |
        grep -o '[^"]\+\.pkg'
}


function getInstallerPath() {
    echo "/tmp/$(basename "`getInstallerUri`")"
}


function getLatestVersionNum() {
    echo "$landingPage" |
        grep -io "MacTeX-[0-9\-\.]\+\(\s\+(\?\(patch\s\+\)\?[0-9\-\.]\+)\?\)\?" |
        head -n1 |
        cut -d- -f2-
}


function getInstalledVersionNum() {
    installed="$(tex --version 2>/dev/null)"
    if [[ -z "$installed" ]]; then
        echo 'none'
        return
    fi
    echo "$installed" |
        grep -oi 'TeX Live [0-9\-\.]\+\(\s\+(\?\(patch\s\+\)\?[0-9\-\.]\+)\?\)\?' |
        head -n1 |
        cut -d' ' -f3-
}


function main() {
    printf "%-30s" "Installing $name..."
    
    installed="$(getInstalledVersionNum)"
    latest="$(getLatestVersionNum)"
    if [[ "$installed" == "$latest" ]]; then
        echo "Already installed $installed"
        return
    fi
      
    echo
    echo "$installed is installed. Installing $latest..."
    
    installerPath="$(getInstallerPath)"
    if ! downloadInstaller "$installerPath"; then
        echo "ERROR: Failed to download. Result was `cat "$installerPath"`"
        return 1
    fi
    if ! runInstaller "$installerPath"; then
        echo "ERROR: Failed to install"
        return 1
    fi
    
    rm "$installerPath"
    
    installed="$(getInstalledVersionNum)"
    if [[ "$latest" == "$installed" ]]; then
        echo "Installed $installed"
        return 0
    else
        echo "ERROR: Update to $latest unsuccessful, version remains at $installed"
        return 1
    fi
}


function downloadInstaller() {
    installerPath="$1"
    
    if [[ -z "$installerPath" ]]; then
        echo "Must specify destination path for installer!"
        return 1
    fi
    
    echo "Downloading from $uri"
    curl --user-agent "$(utils/safariAgent.sh)" -L "$(getInstallerUri)" -o "$installerPath"
    
    if file "$installerPath" | grep ': HTML document text$' 2>/dev/null 1>/dev/null; then
        return 1
    else
        return
    fi
}


function runInstaller() {
    installerPath="$1"
    if [[ ! -e "$installerPath" ]]; then
        echo "ERROR: $installerPath does not exist"
        return 1
    fi
    open "$installerPath"
    success="$?"
    
    # Disabled: dmg-based installer
    if false; then
        echo "Mounting disk image..."
        vol="$(hdiutil attach "$installerPath" -nobrowse |
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
    fi
    
    return $success
}
    
    
main

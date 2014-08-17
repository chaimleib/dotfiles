#!/bin/bash

if [[ ! -e /Applications/Safari.app ]]; then
    echo "Safari is not present on this system." >/dev/stderr
    exit 1
fi

infoPlist="/Applications/Safari.app/Contents/Info.plist"
shortVer=$(defaults read "$infoPlist" CFBundleShortVersionString)
longVer=$(defaults read "$infoPlist" CFBundleVersion)
osVer="$(system_profiler SPSoftwareDataType Software |
    grep 'System Version' | 
    grep -o '[0-9]\+\.[0-9\.]\+' |
    sed 's/\./_/g')" # Gives 10_9_4

echo "Mozilla/5.0 (Macintosh; Intel Mac OS X $osVer) AppleWebKit/${longVer#?} (KHTML, like Gecko) Version/$shortVer Safari/${longVer#?}"

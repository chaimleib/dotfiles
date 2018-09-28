#!/bin/bash

if [[ ! -e /Applications/Safari.app ]]; then
  echo "Safari is not present on this system." >/dev/stderr
  exit 1
fi

this_dir="$(dirname "$0")"
infoPlist="/Applications/Safari.app/Contents/Info.plist"
shortVer=$(defaults read "$infoPlist" CFBundleShortVersionString)
longVer=$(defaults read "$infoPlist" CFBundleVersion)
osVer="$("$this_dir"/osVersion.sh |
  sed 's/\./_/g')" # Gives 10_9_4

echo "Mozilla/5.0 (Macintosh; Intel Mac OS X $osVer) AppleWebKit/${longVer#?} (KHTML, like Gecko) Version/$shortVer Safari/${longVer#?}"

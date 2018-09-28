#!/bin/bash
printf "%-30s" "Installing XCode..."
if xcodebuild -version >/dev/null 2>/dev/null; then
  version="$(xcodebuild -version | grep -o '[0-9]\+\.[0-9\.]\+')"
  echo "Already installed $version"
else
  xcode-select --install
fi


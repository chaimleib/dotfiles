#!/bin/bash

this_dir="$(dirname "$0")"

. "$this_dir"/utils/addDockItem.sh

echo "## Dock ##"
echo Clear the dock\'s apps
defaults write com.apple.dock persistent-apps -array

echo Setting the dock\'s apps
for item in \
  /Applications/Google\ Chrome.app \
  /Applications/Airmail.app \
  /Applications/Calendar.app \
  /Applications/iTerm.app \
; do
  if [[ -d "$item" ]]; then
    addDockApp "$item"
  fi
done


echo Dim hidden apps in the dock
defaults write com.apple.dock showhidden -bool true

echo "Pin dock to left edge"
defaults write com.apple.dock orientation -string "left"

echo "Autohide dock"
defaults write com.apple.dock autohide -bool true

killall Dock


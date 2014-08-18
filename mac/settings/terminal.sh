#!/bin/bash

echo
echo "## Terminal ##"

echo "Close window on shell exit"
# TODO: Get Terminal to reload its prefs and not overwrite this
 /usr/libexec/PlistBuddy -c 'Set "Window Settings:Pro:shellExitAction" 0' ~/Library/Preferences/com.apple.Terminal.plist
 
echo "Set default theme to Pro in Terminal"
defaults write com.apple.Terminal "Default Window Settings" -string Pro
defaults write com.apple.Terminal "Startup Window Settings" -string Pro


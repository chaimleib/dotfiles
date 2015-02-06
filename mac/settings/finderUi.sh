#!/bin/bash

echo
echo "## Finder UI ##"

## Menu bar ##
echo Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMeuBarTransparency -bool false

#echo Disable Notification Center
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

echo Hide menu extras I don\'t like
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" #\
#        "/System/Library/CoreServices/Menu Extras/User.menu"
done

## Saving ##
echo Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

## Login ##
echo Tap to click for me and on login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

echo Ask for password only after delay when screen shuts off
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 10

## File display ##
echo Show attached drives on Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo Show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo Allow text selection in quick look
defaults write com.apple.finder QLEnableTextSelection -bool true

## Mission control ##
echo Don\'t reorder most-recently-used spaces
defaults write com.apple.dock mru-spaces -bool false

echo Quicker Expose animations
defaults write com.apple.dock expose-animation-duration -float 0.1

## Apply changes ##
killall Dock
killall Finder

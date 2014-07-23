#!/bin/bash

sudo -v

# Keep-alive: update existing `sudo` timestamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## UI ##

## Menu bar ##
# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMeuBarTransparency -bool false

# Disable Notification Center
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# hide menu extras I don't like
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
done

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Tap to click for me and on login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad CLicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Ask for password only after delay when screen shuts off
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 10

# Show attached drives
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Don't reorder most-recently-used spaces
defaults write com.apple.dock mru-spaces -bool false

# Quicker Expose animations
defaults write com.apple.dock expose-animation-duration -float 0.1


## Warnings ##
# Disable warning on changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't offer to create backup disks when new disk is inserted
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


## Under the hood ##
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Don't create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## Built-in apps ##
# Don't open "safe" files automatically in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Advanced mode in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


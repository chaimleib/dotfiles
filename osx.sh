#!/bin/bash

## UI ##
# Disable Notification Center
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

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
# Don't create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

## Built-in apps ##
# Don't open "safe" files automatically in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Advanced mode in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


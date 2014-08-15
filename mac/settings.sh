#!/bin/bash

echo "## UI ##"

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

echo Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

echo Tap to click for me and on login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo Ask for password only after delay when screen shuts off
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 10

echo Show attached drives
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo Show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo Don\'t reorder most-recently-used spaces
defaults write com.apple.dock mru-spaces -bool false

echo Quicker Expose animations
defaults write com.apple.dock expose-animation-duration -float 0.1


echo "## Warnings ##"
echo Disable warning on changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo Don\'t offer to create backup disks when new disk is inserted
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


echo "## Under the hood ##"
echo Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

echo Don\'t create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "## Built-in apps ##"
echo Don\'t open "safe" files automatically in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo Advanced mode in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true



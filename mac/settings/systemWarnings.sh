#!/bin/bash

echo
echo "## Warnings ##"
echo Disable warning on changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Don't offer to create backup disks when new disk is inserted"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


#!/bin/bash

echo
echo "## Safari ##"
echo "Don't open \"safe\" files automatically"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "Don't auto-fill credit card data"
defaults write com.apple.Safari AutoFillCreditCardData -bool false

echo "Enable developer features"
defaults write com.apple.Safari WebKitDeveloperExtras -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
#defaults write com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo Send Do Not Track header
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

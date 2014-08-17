#!/bin/bash

echo
echo "## Terminal ##"
echo "Set default theme to Pro in Terminal"
defaults write com.apple.Terminal "Default Window Settings" -string Pro
defaults write com.apple.Terminal "Startup Window Settings" -string Pro

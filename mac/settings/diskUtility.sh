#!/bin/bash

echo
echo "## Disk Utility ##"
echo Advanced mode in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


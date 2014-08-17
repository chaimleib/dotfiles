#!/bin/bash

echo
echo "## System ##"
echo Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

echo Don\'t create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo Restart automatically if the computer freezes
systemsetup -setrestartfreeze on


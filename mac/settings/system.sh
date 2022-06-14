#!/bin/bash

echo
echo "## System ##"

if false; then
  echo Disable the boot chime
  sudo nvram SystemAudioVolume=" "
else
  echo Re-enable the boot chime
  sudo nvram -d SystemAudioVolume
fi

echo Don\'t create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

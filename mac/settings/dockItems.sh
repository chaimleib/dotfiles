#!/bin/bash

this_dir="$(dirname "$0")"

. "$this_dir"/utils/addDockItem.sh

# clear the dock's apps
defaults write com.apple.dock persistent-apps -array

for item in \
    /Applications/Time\ Machine.app \
    /Applications/Safari.app \
    /Applications/Google\ Chrome.app \
    /Applications/Address\ Book.app \
    /Applications/Contacts.app \
    /Applications/iCal.app \
    /Applications/Calendar.app \
; do
    if [[ -d "$item" ]]; then
        addDockApp "$item"
    fi
done


echo Dim hidden apps in the dock
defaults write com.apple.dock showhidden -bool true

killall Dock
    

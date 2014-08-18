#!/bin/bash

dockPrefs="com.apple.dock"
    
function addDockApp() {
    itemPath="$1"
    value="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$itemPath</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
    defaults write "$dockPrefs" persistent-apps -array-add "$value"
}

function addDockFile() {
    itemPath="$1"
    value="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$itemPath</string><key>_CFURLStringType</key><integer>0</integer></dict><key>file-type</key><integer>18</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
    defaults write "$dockPrefs" persistent-apps "$value"
}

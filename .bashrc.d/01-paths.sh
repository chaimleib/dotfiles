#!/bin/bash
removePath .

appendPath /sbin
appendPath /usr/sbin

#prependPath /opt/local/bin
#prependPath ~/.bin

# Stellarpad binaries
appendPath /Applications/Energia.app/Contents/Resources/Java/hardware/tools/lm4f/bin

# Override default binaries with usr binaries
prependPath /usr/local/sbin
prependPath /usr/local/bin

appendPath /usr/local/lib PKG_CONFIG_PATH
appendPath /usr/X11/lib/pkgconfig PKG_CONFIG_PATH

# Go
prependPath ~/go/bin

# Haskell
prependPath ~/.cabal/bin

# Inkscape
appendPath /Applications/Inkscape.app/Contents/Resources/bin

# Google Cloud SDK
[[ "$0" == *bash ]] &&
  [[ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc' ]] &&
  . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
[[ -n "$ZSH_NAME" ]] &&
  [[ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]] &&
  . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'

prependPath "/usr/local/opt/mysql@5.7/bin"

# node
prependPath "/usr/local/share/npm/bin"
prependPath "$HOME/.node_modules_global/bin"


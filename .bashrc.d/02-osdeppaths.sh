#!/bin/bash

# OS-specific
function _addOPPathTree() {
  if ! [ -d "$1" ]; then
    return
  fi
  tree=override
  [ -d "$1/$tree" ] &&
    prependPath "$1/$tree/bin"

  tree=provide
  [ -d "$1/$tree" ] &&
    appendPath "$1/$tree/bin"
}

case "$OSTYPE" in
  darwin*) _addOPPathTree "${HOME}/local/darwin-`uname -m`" ;;
esac
_addOPPathTree "${HOME}/local/$OSTYPE-`uname -m`"
_addOPPathTree "${HOME}/local/all"
return 0

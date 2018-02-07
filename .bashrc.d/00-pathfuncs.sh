#!/bin/bash

function lspath() {
# Displays the members of the path variable on separate lines
  local pathlistname=$1
  [[ -z $pathlistname ]] && pathlistname="PATH"

  eval "local pathlist=\"\${$pathlistname}\""

  echo $pathlist | tr ':' '\n' | awk 'NF > 0' ||
    echo "ERROR in lspath(): pathlistname=$pathlistname pathlist=$pathlist" 1>&2
}

function _removePath() {
# if provided, the argument specifies the name of the variable to
# operate on. Otherwise, it defaults to $PATH.
# DOES NOT export! echoes the result to stdout.
  local pathlistname=$2
  [[ -z $pathlistname ]] && pathlistname="PATH"

  eval "local pathlist=\"\${$pathlistname}\""

  result=''
  for p in `lspath "${pathlistname}" | tr ' ' '\a'`; do
    p="`echo "$p" | tr '\a' ' '`"
    [[ $p != $1 ]] && if [[ -n ${result} ]]; then
      result="${result}:$p"
    else
      result="$p"
    fi
  done
  echo "$result"
}

function removePath() {
# the first argument is the string to remove from the path list.

# if provided, the second argument specifies the name of the variable to
# operate on. Otherwise, it defaults to $PATH.
  local pathlistname=$2
  [[ -z $pathlistname ]] && pathlistname="PATH"

  eval "local pathlist=\"\${$pathlistname}\""
  pathlist="`_removePath "$1" "${pathlistname}"`"

  export $pathlistname="${pathlist}"
}

function prependPath() {
# the first argument is the string to prepend to the path list.

# if provided, the second argument specifies the name of the variable to
# operate on. Otherwise, it defaults to $PATH.
  [[ -d "$1" ]] || return 1
  local pathlistname=$2
  [[ -z $pathlistname ]] && pathlistname="PATH"

  eval "local pathlist=\"\${$pathlistname}\""
  pathlist="`_removePath "${1}" "${pathlistname}"`"

  if [[ -z $pathlist ]]; then
    export $pathlistname="${1}"
  else
    export $pathlistname="${1}:${pathlist}"
  fi
}

function appendPath() {
# the first argument is the string to append to the path list.

# if provided, the second argument specifies the name of the variable to
# operate on. Otherwise, it defaults to $PATH.
  [[ -d "$1" ]] || return 1
  local pathlistname=$2
  [[ -z $pathlistname ]] && pathlistname="PATH"

  eval "local pathlist=\"\${$pathlistname}\""
  pathlist="`_removePath "${1}" "${pathlistname}"`"

  if [[ -z $pathlist ]]; then
    export $pathlistname="${1}"
  else
    export $pathlistname="${pathlist}:${1}"
  fi
}

## Syntax:
##    abspath [path]
# Converts path to an absolute path. If no path given, gives current directory.
function abspath() {
  [[ "$1" != '' ]] && pushd "$1" >/dev/null
  pwd
  [[ "$1" != '' ]] && popd >/dev/null
}

function relpath() {
  python -c "import os.path; print os.path.relpath('$1', '${2:-$PWD}')"
}


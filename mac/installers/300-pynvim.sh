#!/bin/bash
set -e
printf "%-30s %s..." Installing "pynvim"

function abort() { echo "$1" >&2; exit 1; }
function require() { command -v "$1" >/dev/null || abort "Missing: $1"; }

require vim
require pip3

case $(which pip3) in
  */shims/*) MAYBE_SUDO= ;;
  *) MAYBE_SUDO=sudo
esac
$MAYBE_SUDO pip3 install pynvim  # required for vim plug roxma/nvim-yarp

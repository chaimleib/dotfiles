#!/bin/bash

function do_install() {
  if ping -c1 raw.githubusercontent.com; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh |
      bash
  else
    echo "$0: raw.githubusercontent.com unreachable"
    exit 1
  fi
  # nvm install depends on python3 and python3-distutils, and npm
  $INSTALL nodejs npm
}

do_install


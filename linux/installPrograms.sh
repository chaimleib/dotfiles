#!/bin/bash

if [[ "$0" == "-bash" ]]; then
  echo "This file is not intended to be source-d."
  echo "Call this file as an executable."
  exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

sudo apt update
if [ -n "$http_proxy" ]; then
  echo "http_proxy has been unexpectedly set after apt update"
  exit 1
fi
sudo apt upgrade -y
if [ -n "$http_proxy" ]; then
  echo "http_proxy has been unexpectedly set after apt upgrade"
  exit 1
fi
sudo apt autoremove -y
if [ -n "$http_proxy" ]; then
  echo "http_proxy has been unexpectedly set after apt autoremove"
  exit 1
fi

export INSTALL='sudo apt install -y'
for file in $(ls "$this_dir"/installers/*.sh); do
  if [ -n "$http_proxy" ]; then
    echo "http_proxy has been unexpectedly set before executing $file"
    exit 1
  fi
  [ -x "$file" ] && "$file"
done
unset INSTALL
git reset --hard  # undo changes to rc files

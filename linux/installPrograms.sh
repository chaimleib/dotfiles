#!/bin/bash

if [[ "$0" == "-bash" ]]; then
  echo "This file is not intended to be source-d."
  echo "Call this file as an executable."
  exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

if command -v apt &>/dev/null; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
  INSTALL='sudo apt install -y'
elif command -v apk &>/dev/null; then
  sudo apk update
  sudo apk upgrade
  INSTALL='sudo apk add'
elif command -v pacman &>/dev/null; then
  sudo pacman -Syu
  INSTALL='sudo pacman -S --needed --noconfirm'
elif command -v dnf &>/dev/null; then
  sudo dnf update -y
  INSTALL='sudo dnf install -y'
fi
export INSTALL

for file in $(ls "$this_dir"/installers/*.sh); do
  [ -x "$file" ] && "$file"
done
unset INSTALL

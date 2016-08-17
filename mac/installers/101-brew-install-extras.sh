#!/bin/bash
this_dir="$(dirname "$0")"

echo "Installing brew CLI programs..."

while read pkg; do
  brew install $pkg
done < "${this_dir}/brew-extras.txt"


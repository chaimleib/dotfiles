#!/bin/bash
this_dir="$(dirname "$0")"

echo "Installing extra brew CLI programs..."
brew install $(cat "${this_dir}/brew-extras.txt")


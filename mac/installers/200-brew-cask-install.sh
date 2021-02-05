#!/bin/bash
this_dir="$(dirname "$0")"

echo "Installing brew GUI programs..."
brew install --cask $(cat "${this_dir}/brewcask.txt")


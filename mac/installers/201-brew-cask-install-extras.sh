#!/bin/bash
this_dir="$(dirname "$0")"

echo "Installing extra brew GUI programs..."
brew install $(cat "${this_dir}/brewcask-extras.txt")


#!/bin/bash
this_dir="$(dirname "$0")"

echo "Installing brew CLI programs..."
brew install $(cat "${this_dir}/brew.txt")


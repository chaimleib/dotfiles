#!/bin/bash

echo "Setting up extra taps..."
while read tap; do
  echo "  Tapping $tap..."
  brew tap "$tap"
done < "${this_dir}/brewtap-extras.txt"

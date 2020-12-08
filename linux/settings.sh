#!/bin/bash
if [[ "$0" == "-bash" ]]; then
  echo "This file is not intended to be source-d."
  echo "Call this file as an executable."
  exit 1
fi

this_dir=$(abspath "$(dirname "$0")")

for file in $(ls "$this_dir"/settings/*.sh); do
  [ -x "$file" ] && "$file"
done

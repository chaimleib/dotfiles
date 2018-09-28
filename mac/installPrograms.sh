#!/bin/bash

if [[ "$0" == "-bash" ]]; then
 echo "This file is not intended to be source-d."
 echo "Call this file as an executable."
 exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

for file in "$this_dir"/installers/*.sh; do
 if [[ -x "$file" ]]; then
  "$file"
 fi
done


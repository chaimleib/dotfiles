#!/bin/bash
# called by ../linkFiles.sh
# assumes that install_common.sh has been sourced and $mac_dir has been set

pushd "$mac_dir/root" >/dev/null
_slnargs "Library/Application Support/Razer"
popd >/dev/null


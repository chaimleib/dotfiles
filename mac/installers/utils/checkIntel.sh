#!/bin/bash

# Make sure this is an Intel Mac
function checkIntel() {
    arch="$(uname -p)"
    if [[ "$arch" != "i386" && "$arch" != "x86_64" ]]; then
        echo "ERROR: This script is for Intel Macs only."
        return 1
    fi
}

checkIntel

#!/bin/bash

function do_install() {
    [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1
    
    $INSTALL ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
}

do_install


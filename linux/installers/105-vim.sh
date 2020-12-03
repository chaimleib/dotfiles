#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL vim
}

do_install


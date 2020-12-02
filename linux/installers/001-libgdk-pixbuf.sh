#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL libgdk-pixbuf2.0-0
  sudo usermod -a -G video "$USER"
}

do_install


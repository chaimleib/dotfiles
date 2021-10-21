#!/usr/bin/env sh

function do_install() {
  [ -z "$INSTALL" ] && echo "INSTALL not set" && return 1

  $INSTALL imagemagick xsel zip unzip
}

do_install


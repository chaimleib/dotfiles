#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL vim

  # Install plugins and quit
  vim -c :PlugUpdate -c :q -c :q
}

do_install


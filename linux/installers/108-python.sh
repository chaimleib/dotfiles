#!/bin/bash

function do_install() {
  [[ -z "$INSTALL" ]] && echo "INSTALL not set" && return 1

  $INSTALL python python3 python3-distutils python-distutils-extra
}

do_install


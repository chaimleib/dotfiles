#!/usr/bin/env sh

function is_dnf() {
  case "$INSTALL" in
    'sudo dnf'*) return 0 ;;
  esac
  return 1
}

function do_install() {
  [ -z "$INSTALL" ] && echo "INSTALL not set" && return 1

  $INSTALL \
    $( (is_dnf && echo ImageMagick) || echo imagemagick) \
    zip unzip
}

do_install


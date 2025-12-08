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
    niri \
    libsecret \
    kitty \
    waybar \
    fuzzel \
    network-manager-applet

  is_dnf && sudo dnf copr enable solopasha/hyprland && $INSTALL \
    hyprland \
    hypridle \
    hyprlock
}

do_install


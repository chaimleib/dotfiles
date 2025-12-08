#!/bin/bash

if [[ "$0" == "-bash" ]]; then
  echo "This file is not intended to be source-d."
  echo "Call this file as an executable."
  exit 1
fi

this_dir="$(dirname "$0")"
. "$this_dir"/../install_common.sh

this_dir="$(abspath "$(dirname "$0")")"

function install_lin() {
  linhome
  linhomedotconfig
  pushd "$HOME" >/dev/null
  . .bashrc
  popd >/dev/null
}

function linhome() {
  pushd "$this_dir/.." >/dev/null

  _lnargs \
    .bashrc \
    .bashrc.d \
    .bash_logout \
    .gitconfig \
    .gitconfig-en \
    .inputrc \
    .vimrc \
    .vim \
    .zshrc \
    local \
    .hushlogin \
    .ee.bcrc \
    .phy.bcrc \
    .profile \
    .pythonrc.py \
    .tmux.conf

  popd >/dev/null
}

function linhomedotconfig() {
  mkdir -p \
	  "${HOME}/.config/fuzzel" \
	  "${HOME}/.config/hypr" \
	  "${HOME}/.config/kitty" \
	  "${HOME}/.config/niri" \
	  "${HOME}/.config/nvim" \
	  "${HOME}/.config/sway" \
	  "${HOME}/.config/waybar"

  pushd "$this_dir/.." >/dev/null
  _lnargs \
    .config/rg \
    .config/fuzzel/fuzzel.ini \
    .config/hypr/hypridle.conf \
    .config/hypr/hyprland.conf \
    .config/hypr/hyprlock.conf \
    .config/kitty/kitty.conf \
    .config/niri/config.kdl \
    .config/sway/config \
    .config/waybar/config.jsonc \
    .config/waybar/power_menu.xml \
    .config/waybar/style.css
  popd >/dev/null
}

install_lin

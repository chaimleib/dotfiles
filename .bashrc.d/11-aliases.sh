#!/bin/bash

## Basic shell
alias ..='cd ..'
case $OSTYPE in
  darwin*)
    alias ls='ls -G'
    ;;
  solaris*)
    alias ls='gls --color'
    alias tail='gtail'
    have gdircolors && alias dircolors='gdircolors'
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
  cygwin*)
    alias ls='ls --color'
    ;;
esac

alias l='ls -F'
alias lll='ls -CF --color=always | more'
alias llla='ls -CFA --color=always | more'
alias ll='ls -lh'
alias la='ls -ACF'

alias s='source ~/.bashrc'
alias progs='fd -t x . $(for d in $(lspath | sort -u); do [ -d "$d" ] && echo "$d"; done) | sort'

alias dt='date +"%Y-%m-%d"'
alias dtt='date +"%Y-%m-%d-%H-%M-%S%z"'

alias bb='borg create -v --stats --exclude-from ~/.borgignore /run/media/chaimleib/EMF/borg::`dtt` ~'

function sw() {
  tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
  mv "$1" "$tmpfile"
  mv "$2" "$1"
  mv "$tmpfile" "$2"
}

alias search-content='grep --color=always -n'
function rgm() {
  rg --color=always "$@" | cut -c1-500 | more
}
function rgc() {
  rg --color=always "$@" | cut -c1-500
}


## Meta shortcuts
alias s='export CHAIMLEIBSDOTFILES= ;source ~/.profile'
alias v=$EDITOR

alias vb='v ~/.bashrc'
alias va='v ~/.bashrc.d/??-aliases.sh'
alias vh='v ~/.config/hypr/hyprland.conf'
alias vl='v ~/.config/hypr/hyprlock.conf'
alias vni='v ~/.config/niri/config.kdl'
alias vp='v ~/.bashrc.d/??-paths.sh'
alias vpr='v ~/.bashrc.d/??-prompt.sh'
alias vv='v ~/.vimrc'
alias vn='v ~/.config/nvim/init.lua'
alias vw='v ~/.config/waybar/style.css'

## OS-specific shortcuts
case $OSTYPE in
darwin*)
  alias hide='sudo chflags hidden'
  alias unhide='sudo chflags nohidden'

  # replace matlab with octave
  ! have matlab && function matlab() {
    newargs=''
    for arg in "$@"; do
      case $arg in
      -nosplash|-nodesktop) echo "Ignored unknown option: $arg" >/dev/stderr
      ;;
      *) newargs="$newargs $arg"
      ;;
      esac
    done
    octave $newargs
  }

  have brew && function b() {
    echo "Updating..." && brew update -v &&
      echo "Upgrading..." && brew upgrade &&
      echo "Cleaning..." && brew cleanup
  }
  ;;
linux-gnu*)
  have dnf && function b() {
    sudo dnf update
  }
;;
esac


## Program shortcuts
# connect to bus pirate
alias bp='screen /dev/tty.usbserial* 115200 8N1'

# BC
if have bc; then
  [[ -e ~/.ee.bcrc ]] && alias eebc="bc -li ~/.ee.bcrc"
  [[ -e ~/.phy.bcrc ]] && alias pbc="bc -li ~/.phy.bcrc"
fi

[[ $USER = cs9f* ]] && alias g++='g++ -g -Wall -I /home/ff/cs9f/lib'

alias sudo='sudo -E ' # preserve env, trailing space to interpret next aliases

# copy SSH key
alias cpkey='< ~/.ssh/id_ed25519.pub pbcopy'

## Directory shortcuts
function cdalias() {
  # alias maker for cd <dir>
  if [[ -d "$2" ]]; then
  # if err="`type $1 2>&1`"; then
  #     echo "cdalias warning: $err" >&2
  # fi
  alias $1="cd $2"
  fi
}

cdalias cd3    ~/3pp
cdalias cda    /Applications
cdalias cdb    ~/dotfiles/.bashrc.d
cdalias cdc    ~/.config
cdalias cdd    ~/Desktop
cdalias cddc   ~/Documents
cdalias cddot  ~/dotfiles
cdalias cddv   /dev
cdalias cddw   ~/Downloads
cdalias cde    /etc
cdalias cdl    ~/Library
cdalias cdloc  ~/dotfiles/local
cdalias cds    ~/Sites/chaimleib.github.io
cdalias cdu    /usr
cdalias cdul   /usr/local
cdalias cdv    /Volumes
cdalias cdz    ~/.zshrc.d

cdalias cdp    ~/projects
cdalias cdpg   ~/projects/github

if have upower; then
  alias bat='upower -i `upower -e | grep BAT`'
fi

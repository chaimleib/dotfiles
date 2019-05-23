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

function sw() {
  tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
  mv "$1" "$tmpfile"
  mv "$2" "$1"
  mv "$tmpfile" "$2"
}

alias more='less -R --SILENT --hilite-search --status-column'
alias search-content='grep --color=always -n'
function agm() {
  ag --color "$@" | cut -c1-500 | more
}
function agc() {
  ag --color "$@" | cut -c1-500
}


## Meta shortcuts
alias reinit='export CHAIMLEIBSDOTFILES= ;source ~/.profile'
if ! have vim && have vi; then
  if vi -h | grep VIM &>/dev/null ; then
    alias vim='vi --cmd "set nocompat" -u ~/.vimrc'
  else
    alias vim='vi'
  fi
fi
if have nvim; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi
alias v='vim'

if ! have subl && [ -x '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' ]; then
  alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
fi

alias modb='vim ~/.bashrc'
alias moda='vim ~/.bashrc.d/??-aliases.sh'
alias modp='vim ~/.bashrc.d/??-paths.sh'
alias modpr='vim ~/.bashrc.d/??-prompt.sh'
alias modv='vim ~/.vimrc'
alias modn='vim ~/.config/nvim/init.vim'

## OS-specific shortcuts
case $OSTYPE in
darwin*)
  alias hide='sudo chflags hidden'
  alias unhide='sudo chflags nohidden'

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

  have brew && alias brup='echo "Updating..." && brew update -v &&
  echo "Upgrading..." && brew upgrade &&
  echo "Cleaning..." && brew cleanup'
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

# sudo vim should use my own vimrc
alias svim='sudo -E vim'

# copy SSH key
alias cpkey='cat <(cat ~/.ssh/id_rsa.pub | xargs echo -n) <(printf " $USER") | pbcopy'

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

cdalias cda    /Applications
cdalias cdb    ~/dotfiles/.bashrc.d
cdalias cdc    /usr/local/Cellar
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

cdalias cdp    ~/projects
cdalias cdpg   ~/projects/github
cdalias cdpp   ~/Documents/Programming/Python
cdalias cdy    ~/Documents/Programming/Renpy/yesoidos/game

cdg() {
  cd "${GOPATH}/$1"
}

cdi() {
  cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"$1"
}


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

alias more='less -R --hilite-search --status-column'
alias search-content='grep --color=always -n'
function agm() {
    ag --color "$@" | more
}
function agmr() {
    ag --color "$@" --ruby | more
}


## Meta shortcuts
alias reinit='source ~/.bashrc'
if ! have vim && have vi; then
    if vi -h | grep VIM &>/dev/null ; then
        alias vim='vi --cmd "set nocompat" -u ~/.vimrc'
    else
        alias vim='vi'
    fi
fi
alias modb='vim ~/.bashrc'
alias moda='vim ~/.bashrc.d/*aliases.sh'
alias modp='vim ~/.bashrc.d/*paths.sh'
alias modv='vim ~/.vimrc'

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
        echo "Upgrading..." && brew upgrade --all &&
        echo "Cleaning..." && brew cleanup && brew cask cleanup'
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

cdalias cdd    ~/Desktop
cdalias cddw   ~/Downloads
cdalias cde    /etc
cdalias cdv    /Volumes
cdalias cdb    ~/.bashrc.d
cdalias cdbc   ~/.bash_completion.d
cdalias cddot  ~/dotfiles
cdalias cdloc  ~/dotfiles/local
cdalias cddv   /dev
cdalias cdu    /usr
cdalias cdul   /usr/local
cdalias cddc   ~/Documents
cdalias cdg    ~/Google\ Drive
cdalias cdp    ~/Documents/Programming
cdalias cdpp   ~/Documents/Programming/Python
cdalias cda    /Applications
cdalias cdl    ~/Library
cdalias cdi    ~/dotfiles/mac/installers
cdalias cds    ~/Sites/chaimleib.github.io

cdalias cdy    ~/Documents/Programming/Renpy/yesoidos/game
cdalias cdc    ~/Documents/Programming/Coupa
cdalias cdcd   ~/Documents/Programming/Coupa/coupa_development
cdalias cdca   ~/Documents/Programming/Coupa/csna
cdalias cdcb   ~/Documents/Programming/Coupa/csnb
cdalias cdcc   ~/Documents/Programming/Coupa/csnc
cdalias cdsw   ~/Documents/Programming/Coupa/solano-weekly
cdalias cdcp   ~/Documents/Programming/Coupa
cdalias cdpo   ~/Documents/Programming/Coupa/potato

# cdalias cdjl /home2/truthspo/django/django_projects/liespotter
# cdalias cdt  ~/TinCanPython
# cdalias cdx  ~/xapi_LRS_Test-private
# cdalias cdv  ~/TinCanValidator
# cdalias cds  ~/TinCanValidator/lib/schema


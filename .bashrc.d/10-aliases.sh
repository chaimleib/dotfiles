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
        alias ls='ls --color' 
        ;;
    cygwin*)
        alias ls='ls --color'
        ;;
esac

alias l='ls -F'
alias lll='ls -CF --color=always | more'
alias llla='ls -CFa --color=always | more'
alias ll='ls -lh'
alias la='ls -aC'

alias more='less -R --hilite-search --status-column'
alias search-content='grep --color=always -n'


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

alias rsrc='rsync -ravz --exclude ".*.swp" chaimleib@musashiaharon.com:"$( echo .vimrc .bashrc{,.d} .bash_completion{,.d} .hushlogin local )" ~/'
alias rsrcup='rsync -ravz --exclude ".*.swp" ~/.vimrc ~/.bashrc{,.d} ~/.bash_completion{,.d} ~/.hushlogin ~/local chaimleib@musashiaharon.com:~/'


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

alias gir='git rebase'
alias gis='git status'
alias gif='git fetch --all'

## Directory shortcuts
alias cdd='cd ~/Desktop'
alias cddw='cd ~/Downloads'
alias cde='cd /etc'
alias cdb='cd ~/.bashrc.d'
alias cdbc='cd ~/.bash_completion.d'
alias cddv='cd /dev'
alias cddc='cd ~/Documents'
alias cdg='cd ~/Google\ Drive'
alias cdp='cd ~/Documents/Programming'
[[ -d /Applications ]] && alias cda='cd /Applications'
alias cdl='cd ~/Library'

[[ -d ~/Documents/School/ee20 ]] && alias cdee='cd ~/Documents/School/ee20'
[[ -d ~/Documents/School/cs9f ]] && alias cdcs='cd ~/Documents/School/cs9f'

# [[ -d /home2/truthspo/django/django_projects/liespotter ]] && alias cdjl='cd /home2/truthspo/django/django_projects/liespotter'
[[ -d ~/TinCanPython ]] && alias cdt='cd ~/TinCanPython'
[[ -d ~/xapi_LRS_Test-private ]] && alias cdx='cd ~/xapi_LRS_Test-private'
[[ -d ~/tincanschema ]] && alias cds='cd ~/tincanschema'

#!/bin/bash

removePath .

appendPath /sbin
appendPath /usr/sbin

#prependPath /opt/local/bin
# Setting PATH for MacPython 2.6
#prependPath /Library/Frameworks/Python.framework/Versions/2.6/bin

#prependPath ~/.bin

# Stellarpad binaries
appendPath /Applications/Energia.app/Contents/Resources/Java/hardware/tools/lm4f/bin

# Override default binaries with usr binaries
prependPath /usr/local/sbin
prependPath /usr/local/bin

appendPath /usr/local/lib PKG_CONFIG_PATH
appendPath /usr/X11/lib/pkgconfig PKG_CONFIG_PATH

# Qt
case $OSTYPE in
darwin*) prependPath /Developer/Qt*/[0-9]*/clang_64/bin ;;
*linux*)
    TEX_YEAR=$(
        ls /usr/local/texlive/ 2>/dev/null |
        grep -E '^[0-9-]+' |
        sort -r |
        head -1
    )
    if [[ -n "$TEX_YEAR" ]]; then
        # expecting only a directory like x86_64-linux inside bin
        appendPath /usr/local/texlive/$TEX_YEAR/bin/*
        appendPath /usr/local/texlive/$TEX_YEAR/texmf-dist/doc/info INFOPATH
        appendPath /usr/local/texlive/$TEX_YEAR/texmf-dist/doc/man MANPATH
    fi
    ;;
esac

# Django/Liespotter stuff
#prependPath /home2/truthspo/boost/lib LD_LIBRARY_PATH
#prependPath /home2/truthspo/boost/lib DYLD_LIBRARY_PATH

#prependPath /home2/truthspo/django/django_src/django/bin
#prependPath /home2/truthspo/django/django_src PYTHONPATH
#prependPath /home2/truthspo/django/django_projects PYTHONPATH

#prependPath /home2/truthspo/python/bin

# Haskell
prependPath ~/.cabal/bin

# Inkscape
appendPath /Applications/Inkscape.app/Contents/Resources/bin

# ColdFusion
appendPath /Applications/ColdFusion2016/cfusion/bin

# ruby and sass
if [[ -d /usr/local/Cellar/ruby ]]; then
    pushd /usr/local/Cellar/ruby 2>&1 > /dev/null
    prependPath /usr/local/Cellar/ruby/`ls | sort -r | head -1`/bin
    popd 2>&1 > /dev/null
fi
appendPath "$HOME/.rvm/bin"   # Add RVM to PATH for scripting

# OS-specific

function _addOPPathTree() {
    bin_dirs=(
        bin
        sbin
        )
    if [[ -d "$1" ]]; then
        tree=override
        [[ -d "$1/$tree" ]] &&
            for bin in ${bin_dirs[*]}; do
                prependPath "$1/$tree/$bin"
            done
        
        tree=provide
        [[ -d "$1/$tree" ]] &&
            for bin in ${bin_dirs[*]}; do
                appendPath "$1/$tree/$bin"
            done
    fi
}

if [[ "$OSTYPE" == darwin* ]]; then
    _addOPPathTree "${HOME}/local/darwin-`uname -m`"
fi
_addOPPathTree "${HOME}/local/$OSTYPE-`uname -m`"
_addOPPathTree "${HOME}/local/all"


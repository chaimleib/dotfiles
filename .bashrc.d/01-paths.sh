#!/bin/bash

removePath .

appendPath /sbin
appendPath /usr/sbin

#prependPath /opt/local/bin
# Setting PATH for MacPython 2.6
#prependPath /Library/Frameworks/Python.framework/Versions/2.6/bin

#prependPath ~/.bin

# Stellarpad binaries
#appendPath /Applications/Energia.app/Contents/Resources/Java/hardware/tools/lm4f/bin

# Override default binaries with usr binaries
prependPath /usr/local/sbin
prependPath /usr/local/bin

appendPath /usr/local/lib PKG_CONFIG_PATH
appendPath /usr/X11/lib/pkgconfig PKG_CONFIG_PATH

# Qt
case $OSTYPE in
darwin*) prependPath /Developer/Qt*/[0-9]*/clang_64/bin ;;
esac

# Django/Liespotter stuff
#prependPath /home2/truthspo/boost/lib LD_LIBRARY_PATH
#prependPath /home2/truthspo/boost/lib DYLD_LIBRARY_PATH

prependPath /home2/truthspo/django/django_src/django/bin
prependPath /home2/truthspo/django/django_src PYTHONPATH
prependPath /home2/truthspo/django/django_projects PYTHONPATH

prependPath /home2/truthspo/python/bin

# ruby and sass
prependPath /usr/local/Cellar/ruby/2.1.0/bin

# Inkscape
appendPath /Applications/Inkscape.app/Contents/Resources/bin

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

_addOPPathTree "${HOME}/local/$OS-`uname -m`"
_addOPPathTree "${HOME}/local/all"


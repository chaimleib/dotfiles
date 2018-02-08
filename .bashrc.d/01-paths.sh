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

# Google Cloud SDK
[[ "$0" == *bash ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
[[ "$0" == *zsh ]] &&
  [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ] &&
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'

# ruby and sass
if [[ -d /usr/local/Cellar/ruby ]]; then
    pushd /usr/local/Cellar/ruby 2>&1 > /dev/null
    prependPath /usr/local/Cellar/ruby/`ls | sort -r | head -1`/bin
    popd 2>&1 > /dev/null
fi
appendPath "$HOME/.rvm/bin"   # Add RVM to PATH for scripting

# node
prependPath "/usr/local/share/npm/bin"
prependPath "$HOME/.node_modules_global/bin"
prependPath "$HOME/.yarn/bind"


#!/bin/bash
if [ -f /etc/default/keyboard ]; then
  cat << EOF | sudo tee /etc/default/keyboard > /dev/null
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL=pc104
XKBLAYOUT=us
XKBVARIANT=
XBKOPTIONS=ctrl:nocaps

BACKSPACE=guess
EOF

  sudo dpkg-reconfigure -phigh console-setup
fi

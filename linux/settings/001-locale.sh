#!/bin/bash
if [ -f /etc/locale.gen ]; then
  # comment out all lines except en_US.UTF-8 UTF-8
  sudo sed -i'' \
    -e 's/^\([^#]\)/# \1/' \
    -e 's/# \(en_US\.UTF-8 UTF-8\)/\1/' \
    /etc/locale.gen
  sudo locale-gen
  command -v update-locale >/dev/null && sudo update-locale LANG=en_US.UTF-8
fi

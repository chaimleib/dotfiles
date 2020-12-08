#!/bin/bash
if command -v timedatectl >/dev/null; then
  sudo timedatectl set-timezone US/Arizona
else
  sudo ln -sf /usr/share/zoneinfo/US/Arizona /etc/localtime
fi

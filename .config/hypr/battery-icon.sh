#!/bin/bash

battery_data=$(upower -i "$(upower -e | grep BAT)")
percent=$(
  echo "$battery_data" |
    sed -nE 's/^\s+percentage:\s+([[0-9.]+)%/\1/p'
)
level=$(printf 'scale = 3; %d/100\n' "$percent" | bc)
discharging=$(echo "$battery_data" | grep -E '^\s+state:\s+discharging')
if [ -z "$discharging" ]; then
  charging=--charging
else
  unset charging
fi

/home/chaimleib/projects/github/battery-icon/target/debug/battery-icon \
  --foreground "ffffff" \
  --level "$level" \
  $charging \
  /home/chaimleib/projects/github/battery-icon/base-src.svg \
  /home/chaimleib/.config/hypr/battery.svg

magick \
  -background none \
  /home/chaimleib/.config/hypr/battery.svg \
  /home/chaimleib/.config/hypr/battery.png

echo /home/chaimleib/.config/hypr/battery.png

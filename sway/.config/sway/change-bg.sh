#!/usr/bin/bash

SWAYSOCK=$(ls /run/user/1000/sway-ipc* | head -n 1)

/usr/bin/swaymsg output DP-1 bg `/home/ray/.config/sway/random_bg /home/ray/Pictures/Background/liang-landscape/` fill

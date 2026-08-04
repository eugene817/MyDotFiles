#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/disk.sh

DISK=$(df -H / | tail -1 | awk '{print $5}')
sketchybar --set $NAME label="$DISK"

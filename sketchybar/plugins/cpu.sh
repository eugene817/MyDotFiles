#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/cpu.sh

CPU=$(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5"%" }')
sketchybar --set $NAME label="$CPU"

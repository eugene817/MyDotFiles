#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/ram.sh

RAM=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5) }')
sketchybar --set $NAME label="${RAM}%"

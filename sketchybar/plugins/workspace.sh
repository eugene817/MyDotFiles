#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/workspace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.color=0xffa6e3a1 # Зеленый для активного
else
    sketchybar --set $NAME icon.color=0xff585b70 # Серый для неактивных
fi

#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/battery.sh

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ $CHARGING != "" ]]; then
  ICON=""
else
  if [[ $BATT_PERCENT -gt 80 ]]; then ICON=""
  elif [[ $BATT_PERCENT -gt 60 ]]; then ICON=""
  elif [[ $BATT_PERCENT -gt 30 ]]; then ICON=""
  elif [[ $BATT_PERCENT -gt 15 ]]; then ICON=""
  else ICON=""; fi
fi

sketchybar --set $NAME icon="$ICON" label="${BATT_PERCENT}%"

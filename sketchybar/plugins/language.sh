#!/usr/bin/env bash
# ~/.config/sketchybar/plugins/language.sh

# Читаем системный файл macOS, который хранит текущую раскладку, и вырезаем ее название
LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -d = -f 2 | tr -d ' ";')

# Если используешь нестандартные раскладки, система может отдавать "Input Mode".
# В 99% случаев хватает первого варианта, но это fallback.
if [[ -z "$LAYOUT" ]]; then
    LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "Input Mode" | cut -d = -f 2 | tr -d ' ";')
fi

# Сокращаем названия до эстетичных 2-3 букв (можешь добавить свои языки)
case "$LAYOUT" in
    "ABC" | "U.S.") SHORT="EN" ;;
    "Russian" | "Russian-PC") SHORT="RU" ;;
    "Ukrainian" | "Ukrainian-PC") SHORT="UA" ;;
    "Polish") SHORT="PL" ;;
    *) SHORT="$LAYOUT" ;; # Если язык не из списка, выведет как есть
esac

sketchybar --set $NAME label="$SHORT"

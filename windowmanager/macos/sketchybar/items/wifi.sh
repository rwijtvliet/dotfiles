#!/usr/bin/env bash

wifi=(
    icon=""
    label.width=dynamic
    padding_right=7
    background.color="$TRANSPARENT"
    script="$PLUGIN_DIR/wifi.sh"
)

sketchybar \
    --add item wifi right \
    --set wifi "${wifi[@]}" \
    --subscribe wifi wifi_change mouse.clicked \

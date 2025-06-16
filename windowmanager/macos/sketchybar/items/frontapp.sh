#!/usr/bin/env bash

front_app=(
    icon.drawing=off
    label.font="$FONT:Bold:14"
    label.color="$BACKGROUND"
    label.y_offset=1
    associated_display=active
    script='[ "$SENDER" = "front_app_switched" ] && sketchybar --set $NAME label="$INFO"'
)

sketchybar \
    --add item front_app left         \
    --set front_app "${front_app[@]}" \
    --subscribe front_app front_app_switched

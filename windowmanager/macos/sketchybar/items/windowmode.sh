#!/usr/bin/env bash

windowmode=(
    icon.width=0
    icon.color="$GREY"
    icon.font="$FONT:Bold:16.0"
    icon.padding_left=10
    icon.padding_right=10
    label.width=0
    background.color="$TRANSPARENT"
    background.padding_left=10
    background.padding_right=0
    icon.y_offset=2
    script="$PLUGIN_DIR/windows.sh"
    associated_display=active
)

sketchybar \
    --add event window_focus            \
    --add item windowmode left               \
    --set windowmode "${windowmode[@]}"           \
    --subscribe windowmode window_focus mouse.scrolled.global mouse.clicked

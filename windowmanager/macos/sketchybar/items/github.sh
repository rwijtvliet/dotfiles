#!/usr/bin/env bash


github=(
    icon=""
    icon.font.family="$FONT"
    icon.font.size=21
    label="$LOADING_ICON"
    label.font.style="Bold"
    label.font.size=20
    background.padding_right=5
    background.padding_left=5
    update_freq=180
    popup.align=right
    script="$PLUGIN_DIR/github.sh"
)

github_popup_template=(
    drawing=off
    icon.font.family="$FONT"
    icon.font.size=14
    icon.padding_right=10
    label.font.size=14
    padding_left=7
    padding_right=7
    background.corner_radius=12
)

sketchybar \
    --add item github right                 \
    --set github "${github[@]}"        \
    --subscribe github mouse.entered mouse.exited mouse.exited.global mouse.clicked \
    \
    --add item github_popup_template popup.github \
    --set github_popup_template "${github_popup_template[@]}"

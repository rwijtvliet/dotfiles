#!/usr/bin/env bash


source "$CONFIG_DIR/colors.sh"

github_bell=(
    padding_right=6
    update_freq=180
    icon="$BELL"
    icon.font="$FONT:Bold:15.0"
    icon.color="$BLUE"
    label="$LOADING_ICON"
    label.highlight_color="$BLUE"
    popup.align=right
    script="$PLUGIN_DIR/github.sh"
)

github_template=(
    drawing=off
    icon.font.family="$FONT"
    icon.font.size=14
    label.font.size=14
    padding_left=7
    padding_right=7
    background.corner_radius=12
)

sketchybar \
    --add item github_bell right                 \
    --set github_bell "${github_bell[@]}"        \
    --subscribe github_bell  mouse.entered mouse.exited mouse.exited.global mouse.clicked \
    \
    --add item github_template popup.github_bell \
    --set github_template "${github_template[@]}"

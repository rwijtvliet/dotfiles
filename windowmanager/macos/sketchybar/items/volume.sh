#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

volume_source=(
    icon.drawing=off
    label.width=dynamic
    label.align=left
    label.color="$foreground"
    label.padding_left=0
    label.padding_right=10
    script="$PLUGIN_DIR/volume_source.sh"
)

volume_slider=(
    updates=on
    label.drawing=off
    icon.drawing=off
    slider.highlight_color="$primary"
    slider.background.height=5
    slider.background.corner_radius=3
    slider.background.color="$disabled"
    slider.knob=􀀁
    slider.knob.drawing=on
    background.padding_left=0
    background.padding_right=0
    script="$PLUGIN_DIR/volume_slider.sh"
)

volume_icon=(
    padding_left=10
    icon=""
    icon.width=dynamic
    icon.color="$primary"
    icon.font="$FONT:Regular:20.0"
    label.width=dynamic
    label.color="$foreground"
    label.padding_right=0
    script="$PLUGIN_DIR/volume_icon.sh"
)

sketchybar \
    --add item volume_source right \
    --set volume_source "${volume_source[@]}" \
    --subscribe volume_source mouse.clicked volume_change \
    \
    --add slider volume_slider right            \
    --set volume_slider "${volume_slider[@]}"   \
    --subscribe volume_slider mouse.clicked volume_change \
    \
    --add item volume_icon right         \
    --set volume_icon "${volume_icon[@]}" \
    --subscribe volume_icon mouse.clicked volume_change

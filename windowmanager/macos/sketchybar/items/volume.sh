#!/usr/bin/env bash


volume_source=(
    icon.drawing=off
    label.width=dynamic
    label.align=left
    label.padding_left=0
    label.padding_right=10
    script="$PLUGIN_DIR/volume_source.sh"
)

volume_slider=(
    updates=on
    label.drawing=off
    icon.drawing=off
    slider.highlight_color="$PRIMARY"
    slider.background.height=5
    slider.background.corner_radius=3
    slider.background.color="$DISABLED"
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
    icon.color="$PRIMARY"
    icon.padding_left=8
    icon.font="$FONT:Regular:20.0"
    label.width=dynamic
    label.padding_right=0
    script="$PLUGIN_DIR/volume_icon.sh"
)

volume_popup_template=(
    drawing=off
    icon.drawing=off
    label.font.size=14
    padding_left=7
    padding_right=7
    background.corner_radius=12
)

sketchybar \
    --add item volume_source right \
    --set volume_source "${volume_source[@]}" \
    --subscribe volume_source mouse.clicked mouse.entered mouse.exited mouse.exited.global volume_change \
    \
    --add slider volume_slider right            \
    --set volume_slider "${volume_slider[@]}"   \
    --subscribe volume_slider mouse.clicked volume_change \
    \
    --add item volume_icon right         \
    --set volume_icon "${volume_icon[@]}" \
    --subscribe volume_icon mouse.clicked volume_change \
    \
    --add item volume_popup_template popup.volume_source \
    --set volume_popup_template "${volume_popup_template[@]}"

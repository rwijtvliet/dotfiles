#!/usr/bin/env bash

SPACE_ICONS=("x" "2" "3" "4" "5" "6" "7" "8" "9")  # add more if you ever need more

for i in "${!SPACE_ICONS[@]}"
do
    space_idx=$(($i+1))

    space=(
        associated_space="$space_idx"
        icon="${SPACE_ICONS[i]}"
        icon.padding_left=10
        icon.padding_right=10
        icon.color="$FOREGROUND"
        icon.highlight_color="$BACKGROUND"
        label.padding_right=20
        label.color="$GREY"
        label.highlight_color="$BACKGROUND"
        label.font="sketchybar-app-font:Regular:16.0"
        label.y_offset=-1
        label.drawing=off
        background.color="$BACKGROUND"
        background.padding_left=0
        background.padding_right=1
        background.drawing=on
        script="$PLUGIN_DIR/space.sh"
    )

    sketchybar \
        --add space space_$space_idx left    \
        --set space_$space_idx "${space[@]}" \
        --subscribe space_$space_idx mouse.clicked system_woke \
        \
        --add item anchor_left_$space_idx left \
        --set anchor_left_$space_idx width=0 space=$space_idx \
        --add item anchor_right_$space_idx right \
        --set anchor_right_$space_idx width=0 space=$space_idx \
        --add bracket bracket_$space_idx anchor_left_$space_idx anchor_right_$space_idx \
        --set bracket_$space_idx background.color=0xAAFF0000
done

spaces_bracket=(
    background.color="$FOREGROUND_ALT"
    background.border_width=0
    background.padding_left=0
    background.padding_right=0
    script="$PLUGIN_DIR/spaces_global.sh"
)

sketchybar \
    --add event windows_on_spaces       \
    --add bracket spaces_bracket '/space_.*/'  \
    --set spaces_bracket "${spaces_bracket[@]}" \
    --subscribe spaces_bracket space_change windows_on_spaces system_woke \

#!/usr/bin/env bash

SPACE_ICONS=("x" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

for i in "${!SPACE_ICONS[@]}"
do
    space_idx=$(($i+1))

    space=(
        associated_space="$space_idx"
        icon="${SPACE_ICONS[i]}"
        icon.padding_left=10
        icon.padding_right=10
        icon.color="$foreground"
        icon.highlight_color="$background"
        label.padding_right=20
        label.color="$GREY"
        label.highlight_color="$background"
        label.font="sketchybar-app-font:Regular:16.0"
        label.y_offset=-1
        label.drawing=off
        background.color="$background"
        background.padding_left=0
        background.padding_right=1
        background.drawing=on
        script="$PLUGIN_DIR/space.sh"
    )

    sketchybar \
        --add space space_$space_idx left    \
        --set space_$space_idx "${space[@]}" \
        --subscribe space_$space_idx mouse.clicked
done

spaces_bracket=(
    background.color="$BACKGROUND_2"
    background.border_width=0
    background.padding_left=0
    background.padding_right=0
    script="$PLUGIN_DIR/spaces_global.sh"
)

sketchybar \
    --add event windows_on_spaces       \
    --add bracket spaces_bracket '/space_.*/'  \
    --set spaces_bracket "${spaces_bracket[@]}" \
    --subscribe spaces_bracket space_change windows_on_spaces system_woke

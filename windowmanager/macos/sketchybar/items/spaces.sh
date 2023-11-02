#!/usr/bin/env bash

SPACE_ICONS=("x" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    icon.color=$foreground
    icon.highlight_color=$primary
    label.padding_right=20
    label.color=$GREY
    label.highlight_color=$WHITE
    label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=-1
    background.color=$background
    background.border_color=$BACKGROUND_2
    background.padding_left=0
    background.padding_right=1
    background.drawing=on
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space_$sid left    \
             --set space_$sid "${space[@]}" \
             --subscribe space_$sid mouse.clicked
done

spaces_bracket=(
  background.color=$BACKGROUND_2
  background.border_color=$BACKGROUND_2
  background.border_width=0
  background.padding_left=0
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:15.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger space_change'
  icon.color=$WHITE
)

sketchybar --add bracket spaces_bracket '/space_.*/'  \
           --set spaces_bracket "${spaces_bracket[@]}" \
                                                       \
           --add item separator left                   \
           --set separator "${separator[@]}"

#!/usr/bin/env bash

update() {
  source "$CONFIG_DIR/colors.sh"
  if [ "$SELECTED" = "true" ]; then
    color=$background_alt
  else
    color=$background
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.color=$color
}

mouse_clicked() {
  if [ "$BUTTON" = "left" ]; then
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac

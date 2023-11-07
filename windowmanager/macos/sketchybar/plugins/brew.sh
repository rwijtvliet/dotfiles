#!/usr/bin/env bash

update() {
    source "$CONFIG_DIR/colors.sh"

    count="$(brew outdated | wc -l | tr -d ' ')"
    case "$count" in
        [3-5][0-9])
            color=$ORANGE
            ;;
        [1-2][0-9])
            color=$YELLOW
            ;;
        [1-9])
            color=$WHITE
            ;;
        0)
            color=$GREEN
            count=􀆅
            ;;
        *)
            color=$RED
    esac

    sketchybar --set "$NAME" label="$count" icon.color="$color"
}


case "$SENDER" in
    "mouse.clicked")
        popup toggle
        ;;
esac

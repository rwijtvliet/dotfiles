#!/usr/bin/env bash

update() {
    source "$CONFIG_DIR/colors.sh"

    count="$(brew outdated | wc -l | tr -d ' ')"
    case "$count" in
        0)
            color=$GREEN
            count=􀆅
            ;;
        [1-9])
            color=$WHITE
            ;;
        [1-2][0-9])
            color=$YELLOW
            ;;
        [3-5][0-9])
            color=$ORANGE
            ;;
        *)
            color=$RED
    esac

    sketchybar --set "$NAME" label="$count" icon.color="$color"
}


case "$SENDER" in
    "brew_update")
        update
        ;;
    "mouse.clicked")
        if [ "$MODIFIER" = "cmd" ]; then
            brew upgrade
        fi
        update
        ;;
    *)
        update
esac

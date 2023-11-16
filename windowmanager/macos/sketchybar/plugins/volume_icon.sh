#!/usr/bin/env bash

WIDTH=100

VOLUME_100=􀊩
VOLUME_66=􀊧
VOLUME_33=􀊥
VOLUME_10=􀊡
VOLUME_0=􀊣

update() {
    source "$CONFIG_DIR/shared.sh"
    color="$PRIMARY"
    case $INFO in
        0)
            icon=$VOLUME_0
            color="$ALERT"
            ;;
        [1-9])
            icon=$VOLUME_10
            ;;
        [1-2][0-9])
            icon=$VOLUME_33
            ;;
        [3-6][0-9])
            icon=$VOLUME_66
            ;;
        *)
            icon=$VOLUME_100
    esac

    sketchybar --set "$NAME" icon="$icon" icon.color="$color" label="$INFO"
}

toggle_slider() {
    current_width=$(sketchybar --query volume_slider | jq -r ".slider.width")
    if [ "$current_width" -eq "0" ]; then
        sketchybar --animate sin 10 --set volume_slider slider.width=$WIDTH
    else
        sketchybar --animate sin 20 --set volume_slider slider.width=0
    fi
}

case "$SENDER" in
    "mouse.clicked")
        if [ "$BUTTON" = "left" ]; then
            toggle_slider
        fi
        ;;

    "volume_change")
        update
        ;;

    *)
        ;;
esac

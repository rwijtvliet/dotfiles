#!/usr/bin/env bash

WIDTH=100

VOLUME_100=􀊩
VOLUME_66=􀊧
VOLUME_33=􀊥
VOLUME_10=􀊡
VOLUME_0=􀊣

update() {
    case $INFO in
        [6-9][0-9]|100)
            icon=$VOLUME_100
            ;;
        [3-5][0-9])
            icon=$VOLUME_66
            ;;
        [1-2][0-9])
            icon=$VOLUME_33
            ;;
        [1-9])
            icon=$VOLUME_10
            ;;
        0)
            icon=$VOLUME_0
            ;;
        *)
            icon=$VOLUME_100
    esac

    sketchybar --set "$NAME" icon="$icon" label="$INFO"
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

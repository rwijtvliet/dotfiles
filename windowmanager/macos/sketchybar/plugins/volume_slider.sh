#!/usr/bin/env bash

WIDTH=100

update() {
    sketchybar \
        --set "$NAME" slider.percentage="$INFO" \
        --animate tanh 30 --set "$NAME" slider.width=$WIDTH

    sleep 2

    # Check wether the volume was changed another time while sleeping.
    # If no; collapse the slider.
    final_percentage=$(sketchybar --query volume_slider | jq -r ".slider.percentage")
    if [ "$final_percentage" -eq "$INFO" ]; then
        sketchybar --animate tanh 30 --set volume_slider slider.width=0
    fi
}

set_volume() {
    osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
    "mouse.clicked")
        set_volume
        ;;
    "volume_change")
        update
        ;;
esac

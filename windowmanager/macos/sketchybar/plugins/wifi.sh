#!/usr/bin/env bash

update() {
    source "$CONFIG_DIR/shared.sh"
    info="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: '  '/ SSID: / {print $2}')"
    label="$info ($(ipconfig getifaddr en0))"
    icon=$([ -n "$info" ] && echo 􀙇 || echo 􀙈)
    color=$([ -n "$info" ] && echo "$PRIMARY" || echo "$RED")

    sketchybar --set "$NAME" icon="$icon" label="$label" icon.color="$color"
}

click() {
    current_width="$(sketchybar --query "$NAME" | jq -r .label.width)"
    width=$([ "$current_width" -eq "0" ] && echo dynamic || echo 0)

    sketchybar --animate sin 10 --set "$NAME" label.width="$width"
}

case "$SENDER" in
    "wifi_change")
        update
        ;;
    "mouse.clicked")
        click
        ;;
esac

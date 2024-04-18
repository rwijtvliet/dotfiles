#!/usr/bin/env bash

CONNECTED="􀙇"
DISCONNECTED="􀙈"

update() {
	source "$CONFIG_DIR/shared.sh"
	# problem: deprecated
	info="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: ' '/ SSID: / {print $2}')"
	# problem: needs sudo
	info="$(sudo wdutil info | grep ' SSID ' | awk -F ': ' '{print $2}')"
	if [ -n "$info" ]; then
		ip="$(ipconfig getifaddr en0)"
		label="$info ($ip)"
		icon="$CONNECTED"
		color="$PRIMARY"
	else
		label="-"
		icon="$DISCONNECTED"
		color="$ALERT"
	fi
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

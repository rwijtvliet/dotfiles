#!/usr/bin/env bash

IGNORE=("LG HDR 4K" "ThinkPad Thunderbolt 3 Dock USB Audio" "Microsoft Teams Audio")


update(){
    which SwitchAudioSource >/dev/null || exit 0
    source "$CONFIG_DIR/shared.sh"

    current="$(SwitchAudioSource -t output -c)"
    args=(
        --set "$NAME" label="($current)"
        --remove '/volume.device\.*/'
    )

    counter=0
    while IFS= read -r device; do
        must_ignore=false
        for ign in "${IGNORE[@]}"; do
            [ "${ign}" = "$device" ] && must_ignore=true
        done
        if $must_ignore; then
            continue
        fi

        [ "${device}" = "$current" ] \
            && color="$PRIMARY" \
            || color="$FOREGROUND"

        notification=(
            label="${device}"
            label.color="$color"
        )
        args+=(
            --add item "volume.device.$counter" popup."$NAME"
            --set "volume.device.$counter" "${notification[@]}"
            click_script="SwitchAudioSource -s \"${device}\" ; sketchybar --set volume_source popup.drawing=off"
        )
        counter=$((counter+1))
    done <<< "$(SwitchAudioSource -a -t output)"

    sketchybar -m "${args[@]}" > /dev/null
}

popup(){
    sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in

    "mouse.entered")
        popup on
        ;;
    "mouse.exited"|"mouse.exited.global")
        popup off
        ;;
    "mouse.clicked")
        if [ "$BUTTON" = "right" ]; then
            update
        fi
        ;;
    "volume_change")
        update
        ;;
esac

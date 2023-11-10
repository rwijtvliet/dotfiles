#!/usr/bin/env bash

update(){
    source="$(SwitchAudioSource -t output -c)"
    sketchybar --set "$NAME" label="($source)"
}

toggle_popup(){
    drawing=$(sketchybar --query volume_source | jq '.popup.drawing')
    if [ "$drawing" = '"on"' ]; then
        sketchybar -m --set "$NAME" popup.drawing=off
    else
        show_popup
    fi
}

show_popup(){
    which SwitchAudioSource >/dev/null || exit 0
    source "$CONFIG_DIR/colors.sh"

    args=(
        --remove '/volume.device\.*/'
        --set "$NAME" popup.drawing=on
    )
    counter=0
    current="$(SwitchAudioSource -t output -c)"
    while IFS= read -r device; do

        [ "${device}" = "$current" ] \
            && color="$PRIMARY" \
            || color="$DISABLED"

        args+=(
            --add item "volume.device.$counter" popup."$NAME"
            --set "volume.device.$counter" label="${device}" label.color="$color"
            click_script="SwitchAudioSource -s \"${device}\" && \
                sketchybar \
                --set /volume.device\.*/ label.color=$GREY \
                --set \$NAME label.color=$SECONDARY \
                --set volume_source popup.drawing=off"
        )
        counter=$((counter+1))
    done <<< "$(SwitchAudioSource -a -t output)"

    sketchybar -m "${args[@]}" > /dev/null
}

case "$SENDER" in

    "mouse.clicked")
        toggle_popup
        ;;

    "volume_change")
        update
        ;;
esac

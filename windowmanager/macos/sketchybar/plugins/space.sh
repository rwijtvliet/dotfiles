#!/usr/bin/env bash

update() {
    source "$CONFIG_DIR/shared.sh"
    if [ "$SELECTED" = "true" ]; then
        colorrrggbb="$(/usr/local/bin/yabpy space-prop index "$SID" color)"
        color="0xff${colorrrggbb:1:100}"
        color2="0xff${colorrrggbb:1:100}" #use other alpha value to change color of bar
    else
        color="$BACKGROUND"
    fi
    args=(
        icon="$(/usr/local/bin/yabpy space-prop index "$SID" key)"
        icon.highlight="$SELECTED"
        label.highlight="$SELECTED"
        background.color="$color"
    )
    sketchybar \
        --set "$NAME" "${args[@]}" \
        --set "bracket_$SID" background.color="$color2"
}

focus_space() {
    yabai -m space --focus "$SID" 2>/dev/null
}

case "$SENDER" in
    "mouse.clicked")
        if [ "$BUTTON" = "left" ]; then
            focus_space
        fi
        # TODO: is an 'update()' needed here?
        ;;
    "system_woke")
        # To ensure spaces have been prepared (in spaces_global on system_work), we
        # sleep first. (We cannot include the space preparation here, because these
        # functions are executes once _for every space_.)
        sleep 2
        update
        ;;
    *)
        update
        ;;
esac

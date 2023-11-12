#!/usr/bin/env bash

OK_ICON=􀆅

count_to_color() {
    count="$1"
    dark="$2"
    source "$CONFIG_DIR/colors.sh"

    case "$count" in
        0)
            [ -n "$dark" ] && color="$BACKGROUND" || color="$FOREGROUND"
            count="$OK_ICON"
            ;;
        [1-9])
            [ -n "$dark" ] && color="$DARK_BLUE" || color="$BLUE"
            ;;
        [1-2][0-9])
            [ -n "$dark" ] && color="$DARK_WARNING" || color="$WARNING"
            ;;
        *)
            [ -n "$dark" ] && color="$DARK_ALERT" || color="$ALERT"
            ;;
    esac
    echo "$color" "$count"
    return 0
}

#!/usr/bin/env bash


count_to_color() {
    count="$1"
    dark="$2"
    source "$CONFIG_DIR/shared.sh"

    case "$count" in
        [0-9])
            [ -n "$dark" ] && color="$BACKGROUND" || color="$FOREGROUND"
            [ "$count" -eq "0" ] \
                && count="$OK_ICON"
            ;;
        [1-2][0-9])
            [ -n "$dark" ] && color="$DARK_BLUE" || color="$BLUE"
            ;;
        [3-4][0-9])
            [ -n "$dark" ] && color="$DARK_WARNING" || color="$WARNING"
            ;;
        *)
            [ -n "$dark" ] && color="$DARK_ALERT" || color="$ALERT"
            ;;
    esac
    echo "$color" "$count"
    return 0
}

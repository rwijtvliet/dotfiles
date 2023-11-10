#!/usr/bin/env bash

OK_ICON=􀆅

count_to_color() {
    count="$1"
    source "$CONFIG_DIR/colors.sh"

    case "$count" in
        0)
            echo "$FOREGROUND" "$OK_ICON"
            ;;
        [1-9])
            echo "$BLUE" "$count"
            ;;
        [1-2][0-9])
            echo "$WARNING" "$count"
            ;;
        *)
            echo "$ALERT" "$count"
            ;;
    esac
    return 0
}

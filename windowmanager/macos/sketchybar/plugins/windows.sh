#!/usr/bin/env bash

YABAI_STACK=􀏭
YABAI_FULLSCREEN_ZOOM=􀏜
YABAI_PARENT_ZOOM=􀥃
YABAI_FLOAT=􀢌
YABAI_GRID=􀧍

update() {
    source "$CONFIG_DIR/colors.sh"

    window=$(yabai -m query --windows --window)
    stack_idx=$(echo "$window" | jq '.["stack-index"]')

    if [ "$(echo "$window" | jq '.["is-floating"]')" = "true" ]; then
        icon+=$YABAI_FLOAT
        color=$DARK_MAGENTA
    elif [ "$(echo "$window" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
        icon+=$YABAI_FULLSCREEN_ZOOM
        color=$DARK_GREEN
    elif [ "$(echo "$window" | jq '.["has-parent-zoom"]')" = "true" ]; then
        icon+=$YABAI_PARENT_ZOOM
        color=$DARK_BLUE
    elif [[ $stack_idx -gt 0 ]]; then
        last_stack_idx=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
        icon+=$YABAI_STACK
        label="$(printf "[%s/%s]" "$stack_idx" "$last_stack_idx")"
        color=$DARK_RED
    else
        icon=$YABAI_GRID
        color=$BACKGROUND
    fi

    args=(--set "$NAME" icon.color="$color")

    [ -z "$label" ] \
        && args+=(label.width=0) \
        || args+=(label="$label" label.width=dynamic)

    [ -z "$icon" ] \
        && args+=(icon.width=0) \
        || args+=(icon="$icon" icon.width=dynamic)

    sketchybar -m "${args[@]}"
}


mouse_clicked() {
    yabai -m window --toggle float
    update
}


case "$SENDER" in
    "mouse.clicked")
        mouse_clicked
        ;;
    "forced")
        update
        ;;
    "window_focus")
        update
        ;;
    *)
        update
        ;;
esac

#!/usr/bin/env bash


windows_on_spaces () {
    source "$CONFIG_DIR/colors.sh"
    spaces="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

    args=(
        --set spaces_bracket drawing=on
        --set '/space_.*/' background.drawing=on
        --animate sin 1
    )

    while read -r line
    do
        for space_idx in $line # space index
        do
            icon_strip=""
            apps=$(yabai -m query --windows --space "$space_idx" | jq -r ".[].app")
            if [ "$apps" != "" ]; then
                while IFS= read -r app; do
                    icon_strip+=" $("$CONFIG_DIR/plugins/icon_map.sh" "$app")"
                done <<< "$apps"
                args+=(--set "space_$space_idx" label="$icon_strip" label.drawing=on icon.color="$foreground")
            else
                args+=(--set "space_$space_idx" label=""            label.drawing=off icon.color="$almost_invisible")
            fi
        done
    done <<< "$spaces"

    sketchybar -m "${args[@]}"
}

prepare_spaces() {
    yabpy prepare-spaces
}

case "$SENDER" in
    "windows_on_spaces" | "space_change")
        windows_on_spaces
        ;;

    "system_woke" )
        prepare_spaces
        windows_on_spaces
        ;;
    *)
        windows_on_spaces
        ;;
esac

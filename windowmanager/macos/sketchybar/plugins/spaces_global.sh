#!/usr/bin/env bash


windows_on_spaces () {
    source "$CONFIG_DIR/shared.sh"
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
            # Next line should work, but query returns windows not on space_idx.
            apps=$(yabai -m query --windows --space "$space_idx" | jq -r ".[].app")
            # Here we add an additional filter.
            apps=$(yabai -m query --windows --space "$space_idx" | jq -r ".[] | select (.space == $space_idx)" | jq -r ".app")
            if [ "$apps" != "" ]; then
                while IFS= read -r app; do
                    icon_strip+=" $("$CONFIG_DIR/plugins/icon_map.sh" "$app")"
                done <<< "$apps"
                args+=(--set "space_$space_idx" label="$icon_strip" label.drawing=on icon.color="$FOREGROUND")
            else
                args+=(--set "space_$space_idx" label=""            label.drawing=off icon.color="$ALMOST_INVISIBLE")
            fi
        done
    done <<< "$spaces"

    sketchybar -m "${args[@]}"
}

create_spaces() {
    /usr/local/bin/yabpy create-spaces
}

case "$SENDER" in
    "windows_on_spaces" | "space_change")
        windows_on_spaces
        ;;

    "system_woke" )
        create_spaces
        windows_on_spaces
        ;;
    *)
        windows_on_spaces
        ;;
esac

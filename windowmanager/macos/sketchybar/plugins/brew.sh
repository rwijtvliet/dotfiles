#!/usr/bin/env bash


update() {
    source "$CONFIG_DIR/shared.sh"
    source "$CONFIG_DIR/plugins/count_to_color.sh"

    count="$(brew outdated | wc -l | tr -d ' ')"
    read -r labelcolor label <<< "$(count_to_color "$count")"

    args=(
        --set "$NAME" label="$label" label.color="$labelcolor" icon.color="$FOREGROUND"
        --remove '/brew.notification\.*/'
    )

    prev_count=$(sketchybar --query "$NAME" | jq -r .label.value)
    # For sound to play around with:
    # afplay /System/Library/Sounds/Morse.aiff

    counter=0

    while read -r package oldversion comparisonsign newversion
    do
        counter=$((counter + 1))

        # If there are no messages, still make a popup.
        if [ "${package}" = "" ] ; then
            color=$BLUE
            package=""
            oldversion="No outdated packages"
        else
            color=$GREEN
        fi

        notification=(
            icon="$package"
            icon.color="$color"
            label="$oldversion $comparisonsign $newversion"
            position=popup.brew
            drawing=on
            click_script="brew upgrade $package; brew update"
        )

        args+=(
            --clone "brew.notification.$counter" brew_popup_template
            --set "brew.notification.$counter" "${notification[@]}"
        )
    done <<< "$(brew outdated)"

    sketchybar -m "${args[@]}" > /dev/null

    if [ "$count" != "$prev_count" ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
        # Animate a jump.
        sketchybar --animate tanh 15 --set "$NAME" label.y_offset=-5 label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
    "routine"|"forced"|"brew_update")
        update
        ;;
    "mouse.entered")
        popup on
        ;;
    "mouse.exited"|"mouse.exited.global")
        popup off
        ;;
    "mouse.clicked")
        if [ "$BUTTON" = "right" ]; then
            source "$CONFIG_DIR/shared.sh"
            sketchybar --set "$NAME" label="$LOADING_ICON" label.color="$FOREGROUND"
            update
        elif [ "$MODIFIER" = "cmd" ]; then
            brew upgrade
            update
        fi
        ;;
    *)
        update
        ;;
esac

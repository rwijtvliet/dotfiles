#!/usr/bin/env bash

GIT_ISSUE=􀍷
GIT_DISCUSSION=􀒤
GIT_PULL_REQUEST=􀙡
GIT_COMMIT=􀡚
GIT_INDICATOR=􀂓

update() {
    source "$CONFIG_DIR/colors.sh"

    notifications="$(gh api notifications)"
    count="$(echo "$notifications" | jq 'length')"
    args=()
    [ "$notifications" = "[]" ] \
        &&  args+=(--set "$NAME" icon="$BELL" label="0") \
        ||  args+=(--set "$NAME" icon="$BELL_DOT" label="$count")

    prev_count=$(sketchybar --query github.bell | jq -r .label.value)
    # For sound to play around with:
    # afplay /System/Library/Sounds/Morse.aiff

    args+=(--remove '/github.notification\.*/')

    counter=0
    color=$BLUE
    args+=(--set github.bell icon.color="$color")

    while read -r repo url type title
    do
        counter=$((counter + 1))
        important="$(echo "$title" | grep -E -i "(deprecat|break|broke)")"
        color=$BLUE
        padding=0

        if [ "${repo}" = "" ] && [ "${title}" = "" ]; then
            repo="Note"
            title="No new notifications"
        fi
        case "${type}" in
            "'Issue'")
                color=$GREEN
                icon=$GIT_ISSUE
                url="$(gh api "$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")" | jq .html_url)"
                ;;
            "'Discussion'")
                color=$WHITE
                icon=$GIT_DISCUSSION
                url="https://www.github.com/notifications"
                ;;
            "'PullRequest'")
                color=$MAGENTA
                icon=$GIT_PULL_REQUEST
                url="$(gh api "$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")" | jq .html_url)"
                ;;
            "'Commit'")
                color=$WHITE
                icon=$GIT_COMMIT
                url="$(gh api "$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")" | jq .html_url)"
                ;;
        esac

        if [ "$important" != "" ]; then
            color=$RED
            icon=􀁞
            args+=(--set github.bell icon.color="$color")
        fi

        notification=(
            label="$(echo "$title" | sed -e "s/^'//" -e "s/'$//")"
            icon="$icon $(echo "$repo" | sed -e "s/^'//" -e "s/'$//"):"
            icon.padding_left="$padding"
            label.padding_right="$padding"
            icon.color="$color"
            position=popup.github.bell
            icon.background.color="$color"
            drawing=on
            click_script="open $url; sketchybar --set github.bell popup.drawing=off"
        )

        args+=(
            --clone "github.notification.$counter" github.template
            --set "github.notification.$counter" "${notification[@]}"
        )
    done <<< "$(echo "$notifications" | jq -r '.[] | [.repository.name, .subject.latest_comment_url, .subject.type, .subject.title] | @sh')"

    sketchybar -m "${args[@]}" > /dev/null

    if [ "$count" -gt "$prev_count" ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
        sketchybar --animate tanh 15 --set github.bell label.y_offset=5 label.y_offset=0
    fi
}

popup() {
    sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
    "routine"|"forced")
        update
        ;;
    "mouse.entered")
        popup on
        ;;
    "mouse.exited"|"mouse.exited.global")
        popup off
        ;;
    "mouse.clicked")
        popup toggle
        ;;
esac

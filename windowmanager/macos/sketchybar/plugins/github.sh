#!/usr/bin/env bash

ISSUE=
DISCUSSION=
PULL_REQUEST=
COMMIT=
ERROR=
UNKNOWN=

update() {
    source "$CONFIG_DIR/shared.sh"
    source "$CONFIG_DIR/plugins/count_to_color.sh"

    notifications="$(gh api notifications)"
    count="$(echo "$notifications" | jq 'length')"
    read -r labelcolor label <<< "$(count_to_color "$count")"

    args=(
        --remove '/github.notification\.*/'
    )

    prev_count=$(sketchybar --query "$NAME" | jq -r .label.value)
    # For sound to play around with:
    # afplay /System/Library/Sounds/Morse.aiff

    counter=0
    is_important=
    while read -r repo url type title; do
        counter=$((counter + 1))

        if [ -z "${repo}" ] && [ -z "${title}" ]; then
            # If there are no messages, still make a popup.
            color=$BLUE
            icon=""
            url="https://www.github.com/"
            repo=""
            title="No new notifications"

        else

            # Create entry for this message in pop-up
            [ "$url" = "null" ] \
                && url="https://www.github.com/notifications" \
                || url="$(gh api "$(echo "${url}" | sed -e "s/^'//" -e "s/'$//")" | jq .html_url)"
            color=$RED
            icon=$UNKNOWN
            case "${type}" in
                "'CheckSuite'")
                    color=$RED
                    icon=$ERROR
                    ;;
                "'Issue'")
                    color=$GREEN
                    icon=$ISSUE
                    ;;
                "'Discussion'")
                    color=$WHITE
                    icon=$DISCUSSION
                    ;;
                "'PullRequest'")
                    color=$MAGENTA
                    icon=$PULL_REQUEST
                    ;;
                "'Commit'")
                    color=$WHITE
                    icon=$COMMIT
                    ;;
            esac

        fi
        [ -z "$(echo "$title" | grep -E -i "(deprecat|break|broke|failed)")" ] \
            || is_important=true

        notification=(
            icon="$icon  $(echo "$repo" | sed -e "s/^'//" -e "s/'$//")"
            icon.color="$color"
            icon.padding_left=10
            label="$(echo "$title" | sed -e "s/^'//" -e "s/'$//")"
            label.padding_right=10
            position=popup.github
            drawing=on
            click_script="echo $url; open $url; sketchybar --set github popup.drawing=off"
        )

        args+=(
            --clone "github.notification.$counter" github_popup_template
            --set "github.notification.$counter" "${notification[@]}"
        )
    done <<< "$(echo "$notifications" | jq -r '.[] | [.repository.name, .subject.latest_comment_url, .subject.type, .subject.title] | @sh')"

    # Color icon too if >=1 message is important
    [ -z "$is_important" ] \
        && color="$PRIMARY" \
        || color="$ALERT"
    args+=(--set "$NAME" label="$label" label.color="$labelcolor" icon.color="$color")

    # Animate a jump.
    if [ "$count" != "$prev_count" ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
        args+=(
            --animate tanh 15
            --set "$NAME" label.y_offset=-5 label.y_offset=5 label.y_offset=0
        )
    fi

    sketchybar -m "${args[@]}" > /dev/null
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
        if [ "$BUTTON" = "right" ]; then
            source "$CONFIG_DIR/shared.sh"
            sketchybar --set "$NAME" label="$LOADING_ICON" label.color="$FOREGROUND"
            update
        elif [ "$MODIFIER" = "cmd" ]; then
            gh api \
                --method PUT \
                -H "Accept: application/vnd.github+json" \
                -H "X-GitHub-Api-Version: 2022-11-28" \
                /notifications -F read=true
            update
        fi
        ;;
esac

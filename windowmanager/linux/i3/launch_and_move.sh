#!/bin/env bash

APP_CMD="$1"
WORKSPACE="$2"

if [ -z "$APP_CMD" ] || [ -z "$WORKSPACE" ]; then
    echo "Usage: $0 <app_command> <workspace>"
    exit 1
fi

# Launch the app in the background
$APP_CMD &

# Wait for at least one window of this app
for i in $(seq 100); do  # ~100 seconds max
    WIN_IDS=$(xdotool search --class "$(basename $APP_CMD)" --onlyvisible 2>/dev/null)
    if [ -n "$WIN_IDS" ]; then break; fi
    sleep 0.1
done

# Move all windows that exist to the target workspace
for WIN in $WIN_IDS; do
    i3-msg "[id=$WIN] move to workspace $WORKSPACE"
done

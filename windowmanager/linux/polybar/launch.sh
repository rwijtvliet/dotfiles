#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar_main.log 
echo "---" | tee -a /tmp/polybar_stats.log 
polybar -config="$HOME/.config/polybar/config.ini" main 2>&1 | tee -a /tmp/polybar_main.log & disown
polybar -config="$HOME/.config/polybar/config.ini" stats 2>&1 | tee -a /tmp/polybar_stats.log & disown

echo "Bars launched..."

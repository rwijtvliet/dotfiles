#!/usr/bin/env bash

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

brew=(
    icon=""
    icon.font.family="$FONT"
    icon.font.size=18
    label="$LOADING_ICON"
    label.font.style="Bold"
    label.font.size=20
    padding_right=10
    popup.align=right
    script="$PLUGIN_DIR/brew.sh"
)

brew_popup_template=(
    drawing=off
    icon.font.family="$FONT"
    icon.font.size=14
    icon.padding_right=10
    label.font.size=14
    padding_left=7
    padding_right=7
    background.corner_radius=12
)

sketchybar \
    --add event brew_update \
    --add item brew right   \
    --set brew "${brew[@]}" \
    --subscribe brew brew_update mouse.entered mouse.exited mouse.exited.global mouse.clicked \
    \
    --add item brew_popup_template popup.brew \
    --set brew_popup_template "${brew_popup_template[@]}"

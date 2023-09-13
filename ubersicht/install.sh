#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    skip
    ;;

  "windows" )
    skip
    ;;

  "macos" )
    info "Installing app"
    brew install --cask ubersicht
    info "Installing simple-bar"
    mkdir -p $HOME/Library/Application\ Support/Übersicht/widgets/
    git clone https://github.com/Jean-Tinland/simple-bar $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar
    link_file /opt/homebrew/bin/yabai /usr/local/bin/yabai # needed for the simple-bar to work
    ;;

  * )
    ;;
esac

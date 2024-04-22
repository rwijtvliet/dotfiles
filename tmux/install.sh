#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt-get install tmux
    info "Linking config"
    link_public_resource "./tmux.conf" "$HOME/.tmux.conf"
    ;;

  "windows" )
    # raise error to alert user that this script is missing
    fail "to-do"
    exit 1
    ;;

  "macos" )
    info "Installing app"
    brew install tmux
    info "Linking config"
    link_public_resource "./tmux.conf" "$HOME/.tmux.conf"
    ;;
    
  * )
    ;;
esac

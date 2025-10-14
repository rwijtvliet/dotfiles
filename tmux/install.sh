#!/usr/bin/env bash

source ../shared.sh

case "$OS" in
  "linux" )
    info "Installing app"
    sudo apt-get install tmux
    info "Linking config"
    link_public_resource "./tmux.conf" "$HOME/.tmux.conf"
    info "Installing package manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
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
    info "Installing package manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
    ;;
    
  * )
    ;;
esac
